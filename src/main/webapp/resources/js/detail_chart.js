let ctx = document.getElementById("myChart").getContext("2d");
                let data = [
                    ["2023-06-14", 72700],
                    ["2023-06-15", 71500],
                    ["2023-06-16", 71800],
                    ["2023-06-17", 71200],
                    ["2023-06-18", 71400],
                    ["2023-06-19", 70500],
                    ["2023-06-20", 71300],
                    ["2023-06-21", 71600],
                    ["2023-06-22", 72500],
                    ["2023-06-23", 72600],
                    ["2023-06-24", 72700],
                ];
                let lineChart = new Chart(ctx, {
                    type: "line",
                    data: {
                        labels: data.map(function (x) {
                            return x[0];
                        }),
                        datasets: [
                            {
                                data: data.map(function (x) {
                                    return x[1];
                                }),
                                borderColor: "blue",
                                borderWidth: 2,
                            },
                        ],
                    },
                    options: {
                        title: {
                            text: "Samsung Electronics Stock Price",
                        },
                        legend: {
                            display: false,
                        },
                        xAxis: {
                            title: {
                                text: "Date",
                            },
                        },
                        yAxis: {
                            title: {
                                text: "Price (won)",
                            },
                        },
                    },
                });