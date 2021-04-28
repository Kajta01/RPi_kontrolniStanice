"use strict";
class SerialLEDController {
    constructor() {
        this.encoder = new TextEncoder();
        this.decoder = new TextDecoder();
    }
    async init() {
        if ('serial' in navigator) {
            try {
                const port = await navigator.serial.requestPort();
                this.portt = port;
                await port.open({ baudRate: 9600 });
                this.reader = port.readable.getReader();
                this.readable = port.readable;
                const decoder = new TextDecoderStream();
                //this.inputDone = port.readable.pipeTo(decoder.writable);

                this.writer = port.writable.getWriter();
                let signals = await port.getSignals();
                console.log(signals);

                
                var btcCon = document.getElementById("btn-connect");
                
                btcCon.classList.add("btn-success");
                btcCon.classList.remove("btn-primary");
                btcCon.classList.remove("btn-warning");
                btcCon.innerHTML = "Připojeno k USB";
            }
            catch (err) {
                console.error('There was an error opening the serial port:', err);
            }
        }
        else {
            console.error('Web serial doesn\'t seem to be enabled in your browser. Try enabling it by visiting:');
            console.error('chrome://flags/#enable-experimental-web-platform-features');
            console.error('opera://flags/#enable-experimental-web-platform-features');
            console.error('edge://flags/#enable-experimental-web-platform-features');
        }
    }

    async reconnect(){
        console.log("reconnect");
        await this.reader.cancel();
        await this.writer.close();
        await this.portt.close();

        await this.portt.open({ baudRate: 9600 });
        this.reader = this.portt.readable.getReader();
        this.readable = this.portt.readable;
        this.writer = this.portt.writable.getWriter();
    }
    async disconnect(){
        await this.reader.cancel();
        console.log("reader close");
    }
    async write(data) {
        const dataArrayBuffer = this.encoder.encode(data);
        return await this.writer.write(dataArrayBuffer);
    }
    async read() {
        try {
            console.log("k");
            var data = [];
            while (this.readable) {
                try {
                    
                    const { value, done } = await this.reader.read();
                    
                    value.forEach(element => {
                        data.push(element);
                    });
                    console.log(data);
                    if (done) {
                        console.log('[readLoop] DONE', done);
                        this.reader.releaseLock();
                        break;
                      }
                    if ((data[data.length - 1] == 255) && (data[data.length - 2] == 255)) {

                        console.log(data);
                        addRowTable(data);
                        data = [];

                    }
                    if(getSerialMessages.classList.contains("stop")){
                        console.log("read stop");
                        break;
                    }

                } catch (error) {
                    // TODO: Handle non-fatal read error.
                }
            }
        }
        catch (err) {
            const errorMessage = `error reading data: ${err}`;
            console.error(errorMessage);
            return errorMessage;
        }
    }
    
}
function addRowTable(data) {
    // Find a <table> element with id="myTable":
    var table = document.getElementById("myTableBody");
        // Create an empty <tr> element and add it to the 1st position of the table:
        var row,cell;
        // Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
        let c = 0;
        for(let id = 0; id < data.length; id++) {
            if (c == 0) {
                if((data[id] << 8) + data[id + 1] == 65535) return;
                row = table.insertRow(0);
                row.classList.add("NDB");
                cell = row.insertCell(c);
                cell.innerHTML = (data[id] << 8) + data[id + 1];
                c++;
                id++;
            } else if (c == 7){
                c = 0;
                id --;
            } else {
                cell = row.insertCell(c);
                cell.innerHTML = data[id];
                c++;
            }

        }
        


}
jQuery(document).ready(function() {
	jQuery('.tabs .tab-links a').on('click', function(e) {
		var currentAttrValue = jQuery(this).attr('href');

		// Show/Hide Tabs
		jQuery('.tabs ' + currentAttrValue).show().siblings().hide();

		// Change/remove current tab to active
		jQuery(this).parent('li').addClass('active').siblings().removeClass('active');

		e.preventDefault();
	});
});

navigator.serial.addEventListener("disconnect", (event) => {
    var btcCon = document.getElementById("btn-connect");
              btcCon.classList.remove("btn-success");
              btcCon.classList.add("btn-warning");
              btcCon.innerHTML = "Odpojeno od USB";
});