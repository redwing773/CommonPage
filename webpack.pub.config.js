const path = require("path");
// const MiniCssExtractPlugin = require("mini-css-extract-plugin");
// const buildConfig = require('./build/webpack.build');

module.exports = {
  mode: "development",
  // mode: "production",
  devtool: "source-map", //scss 소스맵 기능 추가

  entry: {
  //   entry: path.resolve(__dirname, "./src/main/webapp/resources/js/portalPage/", "entry.js"),
  },

  output: {
  //   filename: "[name]",
  //   path: path.resolve(__dirname, "./src/main/webapp/resources/css/portalPage/")
  },

  devServer: {
    hot: true, //내용이 변경된 모듈을 페이지 새로고침 없이 런타임에서 업데이트하고, 업데이트에 실패할 경우 새로고침을 수행
    static: { //서버 로딩할 static 파일 경로 지정
      directory: path.resolve(__dirname, "./"), // output과 동일해야 devserver만 돌려 추출된 가상 css를 사용가능함 - <!-- <link rel="stylesheet" href="../../css/style.css"> -->
      serveIndex: true
    },
    host: "localhost",
    port: 8083,
    compress: true, //gzip 압축방식을 이용하여 웹 자원 사이즈를 줄임
    // open: ['/html'],
    webSocketServer: false
  },
  // module: {
  //   rules: [
  //     {
  //       test: /\.(sa|sc|c)ss$/i,
  //       use: [
  //         { loader: MiniCssExtractPlugin.loader },
  //         { loader: 'css-loader' },
  //         { 
  //           loader: 'sass-loader',
  //           // options: {
  //           //   additionalData: `
  //           //     $queryString:  "?v=${buildConfig.VERSION}";`
  //           // }
  //         },
  //       ],
  //       exclude: /node_modules/,
  //     },
  //     {
  //       test: /\.(png|jpe?g|gif|svg)$/i,
  //       dependency: { not: ["url"] },
  //       use: [
  //         {
  //           loader: "url-loader"
  //         }
  //       ]
  //     }
  //   ]
  // },

  // plugins: [
  //   new MiniCssExtractPlugin({ filename: "[name].css" })// 컴파일 + 번들링 CSS 파일이 저장될 경로와 이름 지정
  // ]
};
