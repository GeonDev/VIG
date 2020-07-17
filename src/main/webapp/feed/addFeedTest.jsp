<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>


<html>
    <head>
    <style>
        .upload-btn-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        
        .upload-btn {
            border: 2px solid gray;
            color: gray;
            background-color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 20px;
            font-weight: bold;
        }
        
        .upload-btn-wrapper input[type=file] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }
        
        #fileDragDesc {
            width: 100%; 
            height: 100%; 
            margin-left: auto; 
            margin-right: auto; 
            padding: 5px; 
            text-align: center; 
            line-height: 300px; 
            vertical-align:middle;
        }
    </style>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    
    
    
        <script type="text/javascript">
        
        //������
        
        function LoadImage()
		{
			if( typeof window.FileReader !== 'function' )
			{
				alert("FileReader is not supported");
				return;
			}

			var inputFile = document.getElementById('image_file');
			var clsFileReader = new FileReader();
			clsFileReader.onload = function(){
				clsImage = new Image();
				clsImage.onload = function(){
					var canvas = document.getElementById("canvas");
					canvas.width = clsImage.width;
					canvas.height = clsImage.height;

					iCropLeft = 100;
					iCropTop = 100;
					iCropWidth = clsImage.width - 200;
					iCropHeight = clsImage.height - 200;
					iImageWidth = clsImage.width;
					iImageHeight = clsImage.height;

					DrawCropRect();
					AddCropMoveEvent();
				};

				clsImage.src = clsFileReader.result;
			};

			clsFileReader.readAsDataURL(inputFile.files[0]);
		}
        
        //
            $(document).ready(function() {
                $("#input_file").bind('change', function() {
                    selectFile(this.files);
                    //this.files[0].size gets the size of your file.
                    //alert(this.files[0].size);
                });
            });
        
            // ���� ����Ʈ ��ȣ
            var fileIndex = 0;
            // ����� ��ü ���� ������
            var totalFileSize = 0;
            // ���� ����Ʈ
            var fileList = new Array();
            // ���� ������ ����Ʈ
            var fileSizeList = new Array();
            // ��� ������ ���� ������ MB
            var uploadSize = 50;
            // ��� ������ �� ���� ������ MB
            var maxUploadSize = 500;
    
            $(function() {
                // ���� ��� �ٿ�
                fileDropDown();
            });
    
            // ���� ��� �ٿ�
            function fileDropDown() {
                var dropZone = $("#dropZone");
                //Drag��� 
                dropZone.on('dragenter', function(e) {
                    e.stopPropagation();
                    e.preventDefault();
                    // ��Ӵٿ� ���� css
                    dropZone.css('background-color', '#E3F2FC');
                });
                dropZone.on('dragleave', function(e) {
                    e.stopPropagation();
                    e.preventDefault();
                    // ��Ӵٿ� ���� css
                    dropZone.css('background-color', '#FFFFFF');
                });
                dropZone.on('dragover', function(e) {
                    e.stopPropagation();
                    e.preventDefault();
                    // ��Ӵٿ� ���� css
                    dropZone.css('background-color', '#E3F2FC');
                });
                dropZone.on('drop', function(e) {
                    e.preventDefault();
                    // ��Ӵٿ� ���� css
                    dropZone.css('background-color', '#FFFFFF');
    
                    var files = e.originalEvent.dataTransfer.files;
                    if (files != null) {
                        if (files.length < 1) {
                            /* alert("���� ���ε� �Ұ�"); */
                            console.log("���� ���ε� �Ұ�");
                            return;
                        } else {
                            selectFile(files)
                        }
                    } else {
                        alert("ERROR");
                    }
                });
            }
    
            // ���� ���ý�
            function selectFile(fileObject) {
                var files = null;
    
                if (fileObject != null) {
                    // ���� Drag �̿��Ͽ� ��Ͻ�
                    files = fileObject;
                } else {
                    // ���� ���� ��Ͻ�
                    files = $('#multipaartFileList_' + fileIndex)[0].files;
                }
    
                // �������� ���
                if (files != null) {
                    
                    if (files != null && files.length > 0) {
                        $("#fileDragDesc").hide(); 
                        $("fileListTable").show();
                    } else {
                        $("#fileDragDesc").show(); 
                        $("fileListTable").hide();
                    }
                    
                    for (var i = 0; i < files.length; i++) {
                        // ���� �̸�
                        var fileName = files[i].name;
                        var fileNameArr = fileName.split("\.");
                        // Ȯ����
                        var ext = fileNameArr[fileNameArr.length - 1];
                        
                        var fileSize = files[i].size; // ���� ������(���� :byte)
                        console.log("fileSize="+fileSize);
                        if (fileSize <= 0) {
                            console.log("0kb file return");
                            return;
                        }
                        
                        var fileSizeKb = fileSize / 1024; // ���� ������(���� :kb)
                        var fileSizeMb = fileSizeKb / 1024;    // ���� ������(���� :Mb)
                        
                        var fileSizeStr = "";
                        if ((1024*1024) <= fileSize) {    // ���� �뷮�� 1�ް� �̻��� ��� 
                            console.log("fileSizeMb="+fileSizeMb.toFixed(2));
                            fileSizeStr = fileSizeMb.toFixed(2) + " Mb";
                        } else if ((1024) <= fileSize) {
                            console.log("fileSizeKb="+parseInt(fileSizeKb));
                            fileSizeStr = parseInt(fileSizeKb) + " kb";
                        } else {
                            console.log("fileSize="+parseInt(fileSize));
                            fileSizeStr = parseInt(fileSize) + " byte";
                        }
    
                        /* if ($.inArray(ext, [ 'exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml' ]) >= 0) {
                            // Ȯ���� üũ
                            alert("��� �Ұ� Ȯ����");
                            break; */
                        if ($.inArray(ext, [ 'hwp', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'png', 'pdf', 'jpg', 'jpeg', 'gif', 'zip' ]) <= 0) {
                            // Ȯ���� üũ
                            /* alert("����� �Ұ����� ���� �Դϴ�.");
                            break; */
                            alert("����� �Ұ����� ���� �Դϴ�.("+fileName+")");
                        } else if (fileSizeMb > uploadSize) {
                            // ���� ������ üũ
                            alert("�뷮 �ʰ�\n���ε� ���� �뷮 : " + uploadSize + " MB");
                            break;
                        } else {
                            // ��ü ���� ������
                            totalFileSize += fileSizeMb;
    
                            // ���� �迭�� �ֱ�
                            fileList[fileIndex] = files[i];
    
                            // ���� ������ �迭�� �ֱ�
                            fileSizeList[fileIndex] = fileSizeMb;
    
                            // ���ε� ���� ��� ����
                            addFileList(fileIndex, fileName, fileSizeStr);
    
                            // ���� ��ȣ ����
                            fileIndex++;
                        }
                    }
                } else {
                    alert("ERROR");
                }
            }
    
            // ���ε� ���� ��� ����
            function addFileList(fIndex, fileName, fileSizeStr) {
                /* if (fileSize.match("^0")) {
                    alert("start 0");
                } */
    
                var html = "";
                html += "<tr id='fileTr_" + fIndex + "'>";
                html += "    <td id='dropZone' class='left' >";
                html += fileName + " (" + fileSizeStr +") " 
                        //+ "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'> ����</a>"
                        
                        + "<input value='����' type='button' href='#' onclick='deleteFile(" + fIndex + "); return false;'>"
                html += "    </td>"
                html += "</tr>"
    
                $('#fileTableTbody').append(html);
            }
    
            // ���ε� ���� ����
            function deleteFile(fIndex) {
                console.log("deleteFile.fIndex=" + fIndex);
                // ��ü ���� ������ ����
                totalFileSize -= fileSizeList[fIndex];
    
                // ���� �迭���� ����
                delete fileList[fIndex];
    
                // ���� ������ �迭 ����
                delete fileSizeList[fIndex];
    
                // ���ε� ���� ���̺� ��Ͽ��� ����
                $("#fileTr_" + fIndex).remove();
                
                console.log("totalFileSize="+totalFileSize);
                
                if (totalFileSize > 0) {
                    $("#fileDragDesc").hide(); 
                    $("fileListTable").show();
                } else {
                    $("#fileDragDesc").show(); 
                    $("fileListTable").hide();
                }
            }
    
            // ���� ���
            function uploadFile() {
                // ����� ���� ����Ʈ
                var uploadFileList = Object.keys(fileList);
    
                // ������ �ִ��� üũ
                if (uploadFileList.length == 0) {
                    // ���ϵ�� ���â
                    alert("������ �����ϴ�.");
                    return;
                }
    
                // �뷮�� 500MB�� ���� ��� ���ε� �Ұ�
                if (totalFileSize > maxUploadSize) {
                    // ���� ������ �ʰ� ���â
                    alert("�� �뷮 �ʰ�\n�� ���ε� ���� �뷮 : " + maxUploadSize + " MB");
                    return;
                }
    
                if (confirm("��� �Ͻðڽ��ϱ�?")) {
                    // ����� ���� ����Ʈ�� formData�� ������ �Է�
                    var form = $('#uploadForm');
                    var formData = new FormData(form);
                    for (var i = 0; i < uploadFileList.length; i++) {
                        formData.append('files', fileList[uploadFileList[i]]);
                    }
    
                    $.ajax({
                        url : "���ε� ���",
                        data : formData,
                        type : 'POST',
                        enctype : 'multipart/form-data',
                        processData : false,
                        contentType : false,
                        dataType : 'json',
                        cache : false,
                        success : function(result) {
                            if (result.data.length > 0) {
                                alert("����");
                                location.reload();
                            } else {
                                alert("����");
                                location.reload();
                            }
                        }
                    });
                }
            }
        </script>
    </head>
    <body>
        
        <div class="upload-btn-wrapper">
            <input type="file" id="input_file" multiple="multiple" style="height: 100%;" onclick='LoadImage();'/>
            <button class="upload-btn">���ϼ���</button>
        </div>
        <br />
    
        <form name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="post">
    
            <div id="dropZone" style="width: 500px; height: 300px; border-style: solid; border-color: black; ">
                <div id="fileDragDesc" > ������ �巡�� ���ּ���. </div>
            
                
                <table id="fileListTable" width="100%" border="0px">
                    <tbody id="fileTableTbody">
    
                    </tbody>
                </table>
            </div>
    
        </form>
        
        
        <input type="button" onclick="uploadFile(); return false;" class="btn bg_01" value="���� ���ε�">
    
    
    
    </body>
</html>

