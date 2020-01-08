SELECT
    userId,
    projectId,
    busiUnitId,
    businessName,
    projectName,
    initialNum,
    initialAmount,
    ( initialNum + currentNum ) endNum,
    ( initialAmount + currentAmount ) endAmount,
    currentInAmount,
    currentOtherInNum,
    currentOtherInAmount,
    currentOutNum,
    currentOutAmount,
    currentOtherOutNum,
    currentOtherOutAmount
FROM
    (
        SELECT
            userId,
            projectId,
            busiUnitId,
            projectName,
            businessName,
            sum( initial_in_num - initial_out_num ) initialNum,
            sum( initial_in_amount - initial_out_amount ) initialAmount,
            current_in_num currentInNum,
            current_in_amount currentInAmount,
            current_other_in_num currentOtherInNum,
            current_other_in_amount currentOtherInAmount,
            current_out_num currentOutNum,
            current_out_amount currentOutAmount,
            current_other_out_num currentOtherOutNum,
            current_other_out_amount currentOtherOutAmount,
            sum( current_in_num - current_out_num ) currentNum,
            sum( current_in_amount - current_out_amount ) currentAmount
        FROM
            (
                SELECT
                    userId,
                    projectId,
                    busiUnitId,
                    concat( projectNo, '-', abbreviationProjectName ) projectName,
                    concat( subjectNo, '-', abbreviation ) businessName,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num, 0 ) ), 0 ) initial_in_num
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND tbup.state = 1
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                    ) initial_in_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num * tbisd.cost_price, 0 ) ), 0 ) initial_in_amount
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND tbup.state = 1
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                    ) initial_in_amount,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbosd.send_num, 0 ) ), 0 ) initial_out_num
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                    ) initial_out_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( ( tbosd.cost_amount ), 0 ) ), 0 ) initial_out_amount
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                    ) initial_out_amount,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num, 0 ) ), 0 ) current_in_num
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbup.state = 1
                          AND ( tbis.bill_type = 1 OR tbis.bill_type = 3 )
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_in_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num * tbisd.cost_price, 0 ) ), 0 ) current_in_amount
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbup.state = 1
                          AND ( tbis.bill_type = 1 OR tbis.bill_type = 3 )
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_in_amount,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num, 0 ) ), 0 ) current_other_in_num
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbup.state = 1
                          AND ( tbis.bill_type = 2 OR tbis.bill_type = 4 OR tbis.bill_type = 5 )
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_other_in_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( tbisd.receive_num * tbisd.cost_price, 0 ) ), 0 ) current_other_in_amount
                        FROM
                            tb_bill_in_store tbis,
                            tb_bill_in_store_dtl tbisd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbis.id = tbisd.bill_in_store_id
                          AND tbis.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbis.is_delete = 0
                          AND tbis.STATUS = 2
                          AND tbup.state = 1
                          AND ( tbis.bill_type = 2 OR tbis.bill_type = 4 OR tbis.bill_type = 5 )
                          AND tbis.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_other_in_amount,
                    (
                        SELECT
                            ifnull( sum( IFNULL( ( tbosd.send_num ), 0 ) ), 0 ) current_out_num
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND ( tbos.bill_type = 1 OR bill_type = 5 )
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_out_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( ( tbosd.cost_amount ), 0 ) ), 0 ) current_out_amount
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND ( tbos.bill_type = 1 OR bill_type = 5 )
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_out_amount,
                    (
                        SELECT
                            ifnull( sum( IFNULL( ( tbosd.send_num ), 0 ) ), 0 ) current_other_out_num
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_goods tbg,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbosd.goods_id = tbg.id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND (
                                    tbos.bill_type = 2
                                OR tbos.bill_type = 3
                                OR tbos.bill_type = 4
                                OR tbos.bill_type = 6
                                OR tbos.bill_type = 7
                                OR tbos.bill_type = 8
                            )
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_other_out_num,
                    (
                        SELECT
                            ifnull( sum( IFNULL( ( tbosd.cost_amount ), 0 ) ), 0 ) current_other_out_amount
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_goods tbg,
                            tb_base_user_project tbup,
                            tb_base_project tbp
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbosd.goods_id = tbg.id
                          AND tbos.project_id = tbup.project_id
                          AND tbp.id = tbup.project_id
                          AND tbos.is_delete = 0
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND (
                                    tbos.bill_type = 2
                                OR tbos.bill_type = 3
                                OR tbos.bill_type = 4
                                OR tbos.bill_type = 6
                                OR tbos.bill_type = 7
                                OR tbos.bill_type = 8
                            )
                          AND tbos.project_id = tmp.projectId
                          AND tbup.user_id = tmp.userId
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) >= '2019-12-01'
                          AND DATE_FORMAT( tbos.send_date, "%Y-%m-%d" ) <= '2019-12-10'
                    ) current_other_out_amount
                FROM
                    (
                        SELECT
                            tbup.user_id userId,
                            tbis.project_id projectId,
                            tbp.project_no projectNo,
                            tbp.project_name abbreviationProjectName,
                            tbs.subject_no subjectNo,
                            tbs.abbreviation abbreviation,
                            tbp.business_unit_id busiUnitId
                        FROM
                            tb_bill_in_store_dtl tbisd,
                            tb_bill_in_store tbis,
                            tb_base_project tbp,
                            tb_base_subject tbs,
                            tb_base_user_project tbup
                        WHERE
                                1 = 1
                          AND tbisd.bill_in_store_id = tbis.id
                          AND tbis.project_id = tbp.id
                          AND tbp.id = tbup.project_id
                          AND tbp.business_unit_id = tbs.id
                          AND ( tbs.subject_type & 1 = 1 )
                          AND tbis.STATUS = 2
                          AND tbis.is_delete = 0
                          AND tbup.state = 1
                          AND tbup.user_id = 1
                          AND tbp.id = 3
                          AND DATE_FORMAT( tbis.accept_time, "%Y-%m-%d" ) <= '2019-12-10'
                        UNION
                        SELECT
                            tbup.user_id user_id,
                            tbos.project_id projectId,
                            tbp.project_no projectNo,
                            tbp.project_name abbreviationProjectName,
                            tbs2.subject_no subjectNo,
                            tbs2.abbreviation abbreviation,
                            tbp.business_unit_id busiUnitId
                        FROM
                            tb_bill_out_store tbos,
                            tb_bill_out_store_dtl tbosd,
                            tb_base_project tbp,
                            tb_base_subject tbs2,
                            tb_base_user_project tbup
                        WHERE
                                1 = 1
                          AND tbos.id = tbosd.bill_out_store_id
                          AND tbos.project_id = tbp.id
                          AND tbp.id = tbup.project_id
                          AND tbp.business_unit_id = tbs2.id
                          AND tbos.STATUS = 5
                          AND tbup.state = 1
                          AND ( tbs2.subject_type & 1 = 1 )
                          AND tbos.is_delete = 0
                          AND tbup.user_id = 1
                          AND tbp.id = 3
                          AND DATE_FORMAT( tbos.deliver_time, "%Y-%m-%d" ) <= '2019-12-10'
                    ) tmp
                WHERE
                        1 = 1
                GROUP BY
                    tmp.busiUnitId,
                    tmp.projectId
            ) AS v_table
        GROUP BY
            v_table.busiUnitId,
            v_table.projectId
    ) AS out_table
WHERE
        1 = 1
  AND (
        initialNum > 0
        OR initialAmount > 0
        OR currentInNum > 0
        OR currentInAmount > 0
        OR currentOtherInNum > 0
        OR currentOtherInAmount > 0
        OR currentOutNum > 0
        OR currentOutAmount > 0
        OR currentOtherOutNum > 0
        OR currentOtherOutAmount > 0
    );
