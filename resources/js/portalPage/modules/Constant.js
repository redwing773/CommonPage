let device = document.querySelector('#gnbService').dataset.device.toUpperCase();
const CONSTANT = {
     DEVICE: device,
     SUBFILENAME: device !== 'WEB' ? 'm_' : '', 
}
export default CONSTANT;



