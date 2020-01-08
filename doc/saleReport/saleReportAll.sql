SELECT
    sale_report.project_id projectId,
    sale_report.biz_manager_id bizManagerId,
    sale_report.department_id departmentId,
    sale_report.biz_Type bizType,
    sale_report.sale_amount saleAmount,
    sale_report.cost_amount costAmount,
    sale_report.profit_amount profitAmount,
    sale_report.inner_sale_amount innerSaleAmount,
    sale_report.outer_sale_amount outerSaleAmount,
    ( sale_report.rec_amount - sale_report.pay_amount ) feeProfitAmount,
    ( sale_report.profit_amount + sale_report.rec_amount - sale_report.pay_amount ) sumProfitAmount
FROM
    (
        SELECT
            tmp.project_id project_id,
            tmp.biz_manager_id biz_manager_id,
            tmp.department_id department_id,
            tmp.biz_type biz_type,
            SUM( tmp.sale_amount ) sale_amount,
            SUM( tmp.cost_amount ) cost_amount,
            SUM( tmp.profit_amount ) profit_amount,
            (
                SELECT
                    SUM( IFNULL( tbos.send_amount, 0 ) )
                FROM
                    tb_bill_out_store tbos
                        INNER JOIN tb_base_user_project tbup ON tbos.project_id = tbup.project_id
                        INNER JOIN tb_base_project tbp ON tbos.project_id = tbp.id
                        LEFT JOIN tb_base_subject tbs ON tbos.customer_id = tbs.id
                WHERE
                        tbos.bill_type = 1
                  AND tbos.STATUS = 5
                  AND tbup.user_id = 1
                  AND tbup.state = 1
                  AND tbos.send_date >= '2019-11-01'
                  AND tbos.send_date <= '2019-11-29'
                  AND tbos.project_id = tmp.project_id
                  AND ( tbs.subject_type & 1 ) = 1
            ) inner_sale_amount,
            (
                SELECT
                    SUM( IFNULL( tbos.send_amount, 0 ) )
                FROM
                    tb_bill_out_store tbos
                        INNER JOIN tb_base_user_project tbup ON tbos.project_id = tbup.project_id
                        INNER JOIN tb_base_project tbp ON tbos.project_id = tbp.id
                        LEFT JOIN tb_base_subject tbs ON tbos.customer_id = tbs.id
                WHERE
                        tbos.bill_type = 3
                  AND tbos.STATUS = 5
                  AND tbup.user_id = 1
                  AND tbup.state = 1
                  AND tbos.send_date >= '2019-11-01'
                  AND tbos.send_date <= '2019-11-29'
                  AND tbos.project_id = tmp.project_id
                  AND ( tbs.subject_type & 1 ) != 1
            ) outer_sale_amount,
            SUM( tmp.rec_amount ) rec_amount,
            SUM( tmp.pay_amount ) pay_amount
        FROM
            (
                SELECT
                    tbos.project_id project_id,
                    tbp.biz_special_id biz_manager_id,
                    tbp.department_id department_id,
                    tbp.biz_type biz_type,
                    SUM( IFNULL( tbos.send_amount, 0 ) ) sale_amount,
                    SUM( IFNULL( tbos.cost_amount, 0 ) ) cost_amount,
                    SUM( IFNULL( tbos.send_amount, 0 ) - IFNULL( tbos.cost_amount, 0 ) ) profit_amount,
                    0 AS rec_amount,
                    0 AS pay_amount
                FROM
                    tb_bill_out_store tbos
                        INNER JOIN tb_base_user_project tbup ON tbos.project_id = tbup.project_id
                        INNER JOIN tb_base_project tbp ON tbos.project_id = tbp.id
                        LEFT JOIN tb_base_subject tbs ON tbos.customer_id = tbs.id
                WHERE
                        tbos.bill_type = 1
                  AND tbos.STATUS = 5
                  AND tbup.user_id = 1
                  AND tbup.state = 1
                  AND tbos.send_date >= '2019-11-01'
                  AND tbos.send_date <= '2019-11-29'
                GROUP BY
                    tbos.project_id
                UNION ALL
                (
                    SELECT
                        tf.project_id project_id,
                        tbp.biz_special_id biz_manager_id,
                        tbp.department_id department_id,
                        tbp.biz_type biz_type,
                        0 AS sale_amount,
                        0 AS cost_amount,
                        0 AS profit_amount,
                        IFNULL( SUM( IFNULL( tf.rec_amount, 0 ) ), 0 ) AS rec_amount,
                        0 AS pay_amount
                    FROM
                        tb_fee tf
                            INNER JOIN tb_base_user_project tbup ON tf.project_id = tbup.project_id
                            INNER JOIN tb_base_project tbp ON tf.project_id = tbp.id
                    WHERE
                            tf.state = 3
                      AND tf.is_delete = 0
                      AND tbup.user_id = 1
                      AND tbup.state = 1
                      AND ( tf.book_date >= '2019-11-01' )
                      AND ( tf.book_date <= '2019-11-29' )
                    GROUP BY
                        tf.project_id
                ) UNION ALL
                (
                    SELECT
                        tf.project_id project_id,
                        tbp.biz_special_id biz_manager_id,
                        tbp.department_id department_id,
                        tbp.biz_type biz_type,
                        0 AS sale_amount,
                        0 AS cost_amount,
                        0 AS profit_amount,
                        0 AS rec_amount,
                        IFNULL( SUM( IFNULL( tf.pay_amount, 0 ) ), 0 ) AS pay_amount
                    FROM
                        tb_fee tf
                            INNER JOIN tb_base_user_project tbup ON tf.project_id = tbup.project_id
                            INNER JOIN tb_base_project tbp ON tf.project_id = tbp.id
                    WHERE
                            tf.state = 3
                      AND tf.is_delete = 0
                      AND tbup.user_id = 1
                      AND tbup.state = 1
                      AND ( tf.book_date >= '2019-11-01' )
                      AND ( tf.book_date <= '2019-11-29' )
                    GROUP BY
                        tf.project_id
                )
            ) AS tmp
        GROUP BY
            tmp.project_id
    ) sale_report
WHERE
    ! (
                sale_report.sale_amount = 0
            AND sale_report.cost_amount = 0
            AND sale_report.profit_amount = 0
            AND sale_report.inner_sale_amount = 0
            AND sale_report.outer_sale_amount = 0
            AND ( sale_report.rec_amount - sale_report.pay_amount ) = 0
        )
ORDER BY
    sale_report.project_id,
    sale_report.department_id,
    sale_report.biz_manager_id
LIMIT 0,25
