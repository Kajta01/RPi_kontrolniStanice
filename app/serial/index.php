<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Web Serial</title>
  <meta http-equiv="origin-trial" content="AiM0rMslVx2jumsJjQ144QeZTScNmGVMYzBuXoaMQwCd7UHWbQH8Rg20adCN7XWaTMai4HvsUIyx3+blPPiupwEAAABreyJvcmlnaW4iOiJodHRwczovL3VuamF2YXNjcmlwdGVyLXdlYi1zZXJpYWwtZXhhbXBsZS5nbGl0Y2gubWU6NDQzIiwiZmVhdHVyZSI6IlNlcmlhbCIsImV4cGlyeSI6MTU5Njk3OTA1NX0=">
  <link rel="stylesheet" href="../../stylesheet.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>

<body>
  <?php include '../headerStatus.php'; 
  ?>
  <h1>Komunikace USB</h1>
  <div class="container">
    <div id="errorLog">

    </div>
    <div id="connent" class="m-2">
      <button id="btn-connect" class="btn btn-primary">Connect to USB</button>
    </div>

    <div class="tabs">
      <ul class="tab-links nav nav-tabs">
        <li class="nav-item active"><a class="nav-link" href="#tab1">Data o průchodech</a></li>
        <li class="nav-item"><a class="nav-link" href="#tab2">Aktalizace času</a></li>
      </ul>
      <!-- Data z čipů -->
      <div class="tab-content">
        <div id="tab1" class="tab active">
          <p>Po přiložení čipu načte záznamy o průchodech.</p>
          <div class="row justify-content-center">
          <div class="col-6 border-end position-relative">
              <div class="form-check form-switch  position-absolute top-50 start-50 translate-middle">
                <input class="form-check-input" type="checkbox" id="btn-read-data">
                <label class="form-check-label" for="btn-read-data">Spustit čtení</label>
              </div>
            </div>

            <div class="col-6 parametry">
              <p class="mb-0">Možnosti:</p>
              <div class="form-check form-switch pl-5">
                <input class="form-check-input" type="checkbox" id="databaze">
                <label class="form-check-label" for="databaze">Automaticky zapisovat do databáze</label>
              </div>
              <div class="form-check form-switch pl-5">
                <input class="form-check-input" type="checkbox" id="deleteReadData">
                <label class="form-check-label" for="deleteReadData">Po přečtení smazat</label>
              </div>
            </div>
     
          </div>

          <div class="border-top mt-3" style="padding:10px">
            <table id="myTable" style="width:100%">
              <thead>
                <th>ID čipu</th>
                <th>ID stanoviště</th>
                <th>Den</th>
                <th>Hodiny</th>
                <th>Minuty</th>
                <th>Sekundy</th>
                <th>CS</th>
              </thead>
              <tbody id="myTableBody">

              </tbody>
            </table>
          </div>
        </div>
        <!-- ČAS -->
        <div id="tab2" class="tab">
          <p>Po přiležení čipu k zařízení se na čipe nahraje aktuální čas a nasledně je možné čip přiložit 
            k zařízení do kterého chcete čas zapsat.</p>
            <div class="form-check form-switch pl-5">
                <input class="form-check-input" type="checkbox" id="zapisCasu">
                <label class="form-check-label" for="zapisCasu">Spustit</label>
              </div>
          
        </div>
      </div>
    </div>

  </div>

  <script src="serial.js"></script>
  <script>
    const serialLEDController = new SerialLEDController();
    const connect = document.getElementById('btn-connect');
    const getSerialMessages = document.getElementById('btn-read-data');

    connect.addEventListener('pointerdown', () => {
      serialLEDController.init();

    });


    getSerialMessages.addEventListener('pointerdown', async () => {
      if(getSerialMessages.classList.contains("run"))
      {
        console.log("stop");
      getSerialMessages.classList.remove("run");
      getSerialMessages.classList.add("stop"); 
      getSerialMessages.innerHTML = "Stop";
     // await serialLEDController.disconnect();
      }
      else{
      getSerialMessages.classList.remove("stop");
      getSerialMessages.classList.add("run");
      getSerialMessages.innerHTML = "Run";
      getSerialMessage();
      }
    });



    async function getSerialMessage() {
   
      await serialLEDController.reconnect();
      setTimeout(() => {  serialLEDController.write(0x1); }, 5000);
    
      await serialLEDController.read();
    }
  </script>
</body>

</html>