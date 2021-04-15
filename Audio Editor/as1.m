function varargout = as1(varargin)
% AS1 MATLAB code for as1.fig

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @as1_OpeningFcn, ...
                   'gui_OutputFcn',  @as1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% --- Executes just before as1 is made Enable.
function as1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
set(handles.axes1play, 'Enable', 'off');
set(handles.axes1pause, 'Enable', 'off');
set(handles.axes1resume, 'Enable', 'off');
set(handles.axes2play, 'Enable', 'off');
set(handles.axes2pause, 'Enable', 'off');
set(handles.axes2resume, 'Enable', 'off');
set(handles.axes3play, 'Enable', 'off');
set(handles.axes3pause, 'Enable', 'off');
set(handles.axes3resume, 'Enable', 'off');
set(handles.axes3merge, 'Enable', 'off');
set(handles.axes2cut, 'Enable', 'off');
set(handles.axes1cut, 'Enable', 'off');
set(handles.axes3pitchup, 'Enable', 'off');
set(handles.axes3pitchdown, 'Enable', 'off');
set(handles.axes3volumeup, 'Enable', 'off');
set(handles.axes3volumedown, 'Enable', 'off');
set(handles.volumeup, 'Enable', 'off');
set(handles.volumedown, 'Enable', 'off');
set(handles.pitchup, 'Enable', 'off');
set(handles.pitchdown, 'Enable', 'off');
% Setting buttons to initially be disabled, only enabled on certain
% instances
% Update handles structure
guidata(hObject, handles);





function varargout = as1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function axes1import_Callback(hObject, eventdata, handles)


global path;
[Filename, Pathname] = uigetfile('*.wav', 'Import File');
% Retrieve the path / URL of the audio file.
path = strcat (Pathname, Filename);
[x,Fs] = audioread(path);
% Using the audioread feature to set variables to the properties of the
% file, to be edited later.
plot(handles.axes1, x);

% Plotting the audio data of the file on the first axes.
handles.a = audioplayer(x,Fs);
guidata(hObject,handles);
% The handles feature allows the function to be saved, so that simple
% commands such as play, pause, resume can be used on the audio.
set(handles.axes1play, 'Enable', 'on');
set(handles.axes1pause, 'Enable', 'on');
set(handles.axes1resume, 'Enable', 'on');
set(handles.axes1cut, 'Enable', 'on');
set(handles.volumeup, 'Enable', 'on');
set(handles.volumedown, 'Enable', 'on');
% Enable the audio editing buttons for the first axes, where the audio file
% is imported. 







function axes1play_Callback(hObject, eventdata, handles)

play(handles.a);
%Using handles.a the audio can simply be played using play() as opposed to
%sound() this receives more/better arguments such as pause and resume. 



function axes1pause_Callback(hObject, eventdata, handles)
pause(handles.a)


function axes1resume_Callback(hObject, eventdata, handles)
resume(handles.a)

function cutValueAxes1_Callback(hObject, eventdata, handles)
global cut1;
cut1 = str2double(get(hObject, 'String'));


function cutEndAxes2_Callback(hObject, eventdata, handles)
global cut2; 
cut2 = str2double(get(hObject, 'String'));

function axes1cut_Callback(hObject, eventdata, handles)
global path;
global firstcut;
global cut1;
global cut2;
[x,Fs] = audioread(path);
firstcut=x(Fs*cut1:Fs*cut2);
length(firstcut);

sound(firstcut, Fs);
%Cuts 5 seconds of audio from the song and extracts it as a track


function volumedown_Callback(hObject, eventdata, handles)
global path;
global newsong;

[x,Fs] = audioread(path);
newsong=x(Fs*3:Fs*5)*0.2;
% No current set way to edit volume in audioread, close as can get
sound(newsong, Fs);
handles.a = audioplayer(newsong, Fs);
guidata(hObject,handles);
% Overwritten the handles function with the new audio data so the
% play/pause/resume buttons work on it


function volumeup_Callback(hObject, eventdata, handles)
global path;
global newsong;

[x,Fs] = audioread(path);
newsong=x(Fs*6:Fs*7)*2;
sound(newsong, Fs);
handles.a = audioplayer(newsong, Fs);
guidata(hObject,handles);


function axes2import_Callback(hObject, eventdata, handles)


global path2;
global y;
[Filename, Pathname] = uigetfile('*.wav', 'Import File');
path2 = strcat (Pathname, Filename);
[y,Fs] = audioread(path2);
plot(handles.axes2, y);
handles.b = audioplayer(y,Fs);
guidata(hObject,handles);
set(handles.axes2play, 'Enable', 'on');
set(handles.axes2pause, 'Enable', 'on');
set(handles.axes2resume, 'Enable', 'on');
set(handles.axes2cut, 'Enable', 'on');
set(handles.pitchup, 'Enable', 'on');
set(handles.pitchdown, 'Enable', 'on');


function axes2record_Callback(hObject, eventdata, handles)

global recObj;
global y;
Fs = 44100;
% Setting the frequency outside of the audio object
recObj = audiorecorder(Fs, 16, 2)
% Arguments for the audio data 
disp('Start speaking.')
% displays in the command window
recordblocking(recObj, 5);
% records for 5 seconds
disp('End of Recording.');
y = getaudiodata(recObj);
plot(handles.axes2, y);
Fs = 44100;
handles.b = audioplayer(y,Fs);
guidata(hObject,handles);
% https://uk.mathworks.com/help/matlab/import_export/record-and-play-audio.html

set(handles.axes2play, 'Enable', 'on');
set(handles.axes2pause, 'Enable', 'on');
set(handles.axes2resume, 'Enable', 'on');



function axes2play_Callback(hObject, eventdata, handles)

 play(handles.b);




function axes2pause_Callback(hObject, eventdata, handles)

pause(handles.b);



function axes2resume_Callback(hObject, eventdata, handles)

resume(handles.b)


function axes2save_Callback(hObject, eventdata, handles)
global y;
filename = 'new_recording.wav';
audiowrite(filename, y, 44100);
% Saving the new recording as a wav file using audiowrite and a pre-set
% frequency


function pitchdown_Callback(hObject, eventdata, handles)

global path2;
global secondcut;
[x,Fs] = audioread(path2);
secondcut=x(1:Fs*2);
sound(x, 0.7*Fs);
% Plays the original audio file but with a reduced pitch




function pitchup_Callback(hObject, eventdata, handles)

global path2;
global secondcut;
[x,Fs] = audioread(path2);
secondcut=x(1:Fs*2);
sound(x, 2*Fs);
% Plays the original audio file but with an increased pitch


function axes2cut_Callback(hObject, eventdata, handles)

global path2;
global secondcut;
[x,Fs] = audioread(path2);
secondcut=x(1:Fs*5);
length(secondcut);
% Cuts 5 seconds of audio from the imported / recorded audio 
sound(secondcut, Fs);
set(handles.axes3merge, 'Enable', 'on');
% Enables the merge button once the audio file has been extracted for
% reliability purposes


function axes3merge_Callback(hObject, eventdata, handles)

set(handles.axes3play, 'Enable', 'on');
set(handles.axes3pause, 'Enable', 'on');
set(handles.axes3resume, 'Enable', 'on');
set(handles.axes3pitchup, 'Enable', 'on');
set(handles.axes3pitchdown, 'Enable', 'on');
set(handles.axes3volumeup, 'Enable', 'on');
set(handles.axes3volumedown, 'Enable', 'on');

global firstcut;
global secondcut;
global newsound;

L=min(length(firstcut),length(secondcut));
newsound = firstcut(1:L) + secondcut(1:L);
%make two sound files the length of whichever is shortest


%newsound = firstcut+secondcut;
% Combines the imported song from axes1 and the recorded audio from axes 2
% Can only concatenate audio that is the same length
Fs = 44100;
plot(handles.axes3, newsound);
% plots the new sound on the 3rd axes
handles.c = audioplayer(newsound,Fs);
guidata(hObject,handles);


function axes3import_Callback(hObject, eventdata, handles)


global path3;
global newsound;
[Filename, Pathname] = uigetfile('*.wav', 'Import File');
% Optional import instead of merging audio 
% Can be used after merge + save for reliability purposes
path3 = strcat (Pathname, Filename);
[newsound,Fs] = audioread(path3);
plot(handles.axes3, newsound);
handles.c = audioplayer(newsound,Fs);
guidata(hObject,handles);
set(handles.axes3play, 'Enable', 'on');
set(handles.axes3pause, 'Enable', 'on');
set(handles.axes3resume, 'Enable', 'on');
set(handles.axes3pitchup, 'Enable', 'on');
set(handles.axes3pitchdown, 'Enable', 'on');
set(handles.axes3volumeup, 'Enable', 'on');
set(handles.axes3volumedown, 'Enable', 'on');



function axes3play_Callback(hObject, eventdata, handles)

play(handles.c);


function axes3pause_Callback(hObject, eventdata, handles)

pause(handles.c);


function axes3resume_Callback(hObject, eventdata, handles)

resume(handles.c)

function axes3export_Callback(hObject, eventdata, handles)

global newsound;
filename = uiputfile({'*.wav'});
% open file prompt
Fs = 44100;
audiowrite(filename, newsound, Fs);
% Save the merged audio tracks as a new one in wav format




function axes3volumedown_Callback(hObject, eventdata, handles)

global newsound;
Fs = 44100;
volumedown = newsound(Fs*3:Fs*5)*0.2;
handles.c = audioplayer(volumedown, Fs);
guidata(hObject,handles);
% Edit the volume of the new merged tracks as one





function axes3volumeup_Callback(hObject, eventdata, handles)

global newsound;
Fs = 44100;
volumedown = newsound(Fs*5:Fs*5)*2;
handles.c = audioplayer(volumedown, Fs);
guidata(hObject,handles);



function axes3pitchdown_Callback(hObject, eventdata, handles)

global newsound;
Fs = 30000;
handles.c = audioplayer(newsound, Fs);
guidata(hObject,handles);
% Edits the frequency of the new track (created by the merge) and
% overwrites handles.c with its data, allowing it to be controlled using
% the play/pause/resume buttons like the original track, instead of just
% playing the new sound like in axes1 and 2.





function axes3pitchup_Callback(hObject, eventdata, handles)

global newsound;
Fs = 88200;
handles.c = audioplayer(newsound, Fs);
guidata(hObject,handles);





function cutValueAxes1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function cutEndAxes2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function helpButton_Callback(hObject, eventdata, handles)


h = msgbox({'Help' 'Import a song in the first axes' 'Record a song in the second axes'});
%display help text via button press