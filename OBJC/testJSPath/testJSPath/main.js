require('NSURL', 'NSData', 'UIApplication')
defineClass("ViewController", {

            tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if (!cell) {
            cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
            }
            cell.textLabel().setText("1111");
            var redColor = require('UIColor').redColor();
            cell.setBackgroundColor(redColor);
            return cell
            },

            //instance method definitions
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            var row = indexPath.row()

            if (row == 2) {  // 加上判断越界的逻辑
             self.btnClicked()
            console.log('ddsds')

            var url = NSURL.URLWithString('');
            console.log(url)
            var data = NSData.dataWithContentsOfURL(url);

            console.log(url)
            if (!data){
            console.log('dddddd')
            }

            console.log('sssss')
            var vc = require('SecondViewController').alloc().init();

//            self.navigationController().pushViewController_animated(vc,YES);


//            var cell = tableView.cellForRowAtIndexPath(indexPath);
//            var whiteColor = require('UIColor').whiteColor();
//            cell.setBackgroundColor(whoteColor);
            }
            },

//            viewWillAppear: function(animated){
//
//            console.log('sss')
//
//                        var data = self.data()
//                        console.log(data)
//            self.super.viewWillAppear(animated)
//            }

            btnClicked: function(){

            console.log('btn')
            var url = NSURL.URLWithString('https://www.baidu.com/')

            self.openUrl(url)
            }

            },



            {});