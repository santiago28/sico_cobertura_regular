{{ content() }}
<h1>Dashboard</h1>
<div>
  <div class="col-md-6">
    <h4>Visitas</h4>
    <canvas id="DashboardAdmin" width="1000" height="400"></canvas>
    <br>
  </div>
</div>
<script>
var id_cargo = <?php echo $id_cargo; ?>;
var data1 = <?php  echo $datos_dashboard; ?> ;
var data_abiertas = [];
var data_cerradas = [];
data_abiertas.push(data1[0].abiertas);
data_cerradas.push(data1[0].cerradas);
if (id_cargo == 1) {
  var data = [{
    label: "Visitas Abiertas",
    type: "bar",
    stack: "Base",
    backgroundColor: 'rgba(54, 235, 162, 0.2)',
    borderColor: 'rgba(54, 235, 162, 1)',
    borderWidth: 1,
    data: data_abiertas,
  },
  {
    label: "Visitas Cerradas",
    type: "bar",
    stack: "Base",
    backgroundColor: 'rgba(255, 99, 132, 0.2)',
    borderColor: 'rgba(255, 99, 132, 1)',
    borderWidth: 1,
    data: data_cerradas,
  }];
  console.log(data);
  var ctx = document.getElementById("DashboardAdmin");
  var chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ["abiertas", "cerradas"],
      datasets: data
    },
    options: {
      responsive: true,
      legend: {
        position: 'right'
      },
      scales: {
        xAxes: [{
          stacked: true
        }],
        yAxes: [{
          ticks: {
            beginAtZero: true,
            userCallback: function(label, index, labels) {
              // when the floored value is the same as the value we have a whole number
              if (Math.floor(label) === label) {
                return label;
              }
            },
          }
        }]
      }
    }
  });
}


</script>
