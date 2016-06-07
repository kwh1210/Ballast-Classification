function  saveInfo( vidInfo,path,opt,name )
%this function is to save information for the convenience of debugging
%  
info.path = path;
info.opt = opt;
info.vidInfo = vidInfo;
name = ['info_',name,'.mat'];
save(fullfile(path.processed,name),'-struct','info');

end

