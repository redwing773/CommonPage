export const device = (() => {
     if (document.querySelector('#gnbService')) {
          return document.querySelector('#gnbService').dataset.device.toUpperCase();
     }
     else {
          return document.querySelector('#top_content').dataset.device.toUpperCase();
     }
})();

export const SERVICE = document.querySelector('#top_content').dataset.service;
export const SERVICETYPE = document.querySelector('#top_content').dataset.serviceType;

export const CONSTANT = {
     DEVICE: device,
     SUBFILENAME: device == 'WEB' ? '' : 'm_',
}

export const LOGINGNBURL = `./modules/${CONSTANT.SUBFILENAME}CommonPageLoginGnb.html`;

export const TOPBANNERURL = {
     CommonPage: `./modules/${CONSTANT.SUBFILENAME}CommonPageTopBanner.html`,
     ContestPage: `./modules/${CONSTANT.SUBFILENAME}ContestPageTopBanner.html`,
     get CommonPage6p() {
          if (SERVICETYPE === "before") {
               return `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage6pBeforeTopBanner.html`;
          } else if (SERVICETYPE === "after") {
               return `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage6pAfterTopBanner.html`;
          }
     },
     NewTeacher: `./modules/${CONSTANT.SUBFILENAME}NewTeacherTopBanner.html`,
}
export const TOPCONTENTURL = {
     CommonPage: `./modules/${CONSTANT.SUBFILENAME}CommonPageTopContent.html`,
     ContestPage: `./modules/${CONSTANT.SUBFILENAME}ContestPageTopContent.html`,
     get CommonPage6p() {
          if (SERVICETYPE === "before") {
               return `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage6pBeforeTopContent.html`;
          } else if (SERVICETYPE === "after") {
               return `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage6pAfterTopContent.html`;
          }
     },
     NewTeacher: `./modules/${CONSTANT.SUBFILENAME}NewTeacherTopContent.html`,
     CommonPage7s: null,
     CommonPage9p: `./modules/${CONSTANT.SUBFILENAME}CommonPage9pBeforeTopContent.html`,
}

export const TABURLS = {
     CommonPage: [
          `./modules/3p_module/${CONSTANT.SUBFILENAME}CommonPage-tab1.html`,
          `./modules/3p_module/${CONSTANT.SUBFILENAME}CommonPage-tab2.html`,
          `./modules/3p_module/${CONSTANT.SUBFILENAME}CommonPage-tab3.html`,
          `./modules/3p_module/${CONSTANT.SUBFILENAME}CommonPage-tab4.html`,
          `./modules/3p_module/${CONSTANT.SUBFILENAME}CommonPage-tab5.html`,
     ],
     get CommonPage6p() {
          if (SERVICETYPE === "before") {
               return [
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}tab1_before.html`,
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage-tab2.html`,
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}tab3_before.html`,
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage-tab4.html`,
               ]
          } else if (SERVICETYPE === "after") {
               return [
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}tab1_after.html`,
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}tab2_after.html`,
                    `./modules/6p_module/${CONSTANT.SUBFILENAME}tab3_after.html`,
               ]
          }
     },
     CommonPage7s: [
          `./modules/7s_module/${CONSTANT.SUBFILENAME}7s-tab1.html`,
          `./modules/7s_module/${CONSTANT.SUBFILENAME}7s-tab2.html`,
          `./modules/7s_module/${CONSTANT.SUBFILENAME}7s-tab3.html`,
          `./modules/7s_module/${CONSTANT.SUBFILENAME}7s-tab4.html`,
     ],
}

