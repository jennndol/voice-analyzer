function myclose_callback(src,evnt)
selection = questdlg('Apakah Anda Ingin Keluar?',...
      '',...
      'Ya','Tidak','Ya'); 
   switch selection, 
      case 'Ya',
         delete(gcf)
      case 'Tidak'
      return 
   end
end