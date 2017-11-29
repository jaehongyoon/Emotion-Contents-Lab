function varargout = GUI_polar(varargin)
%GUI_POLAR M-file for GUI_polar.fig
%      GUI_POLAR, by itself, creates a new GUI_POLAR or raises the existing
%      singleton*.
%
%      H = GUI_POLAR returns the handle to a new GUI_POLAR or the handle to
%      the existing singleton*.
%
%      GUI_POLAR('Property','Value',...) creates a new GUI_POLAR using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_polar_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_POLAR('CALLBACK') and GUI_POLAR('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_POLAR.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_polar

% Last Modified by GUIDE v2.5 28-May-2015 14:58:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_polar_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_polar_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_polar is made visible.
function GUI_polar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for GUI_polar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_polar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_polar_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn1.
function btn1_Callback(hObject, eventdata, handles)
% hObject    handle to btn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'default_data_Folder');
    disp('no default_data_folder found')
    disp('initialize from current m.file directory')
    default_data_Folder = pwd;
else
    default_data_Folder = handles.default_data_Folder;
end

[au_name neutral_path] = uigetfile(default_data_Folder,...
    'Open neutral data');
default_data_Folder = neutral_path;

% set data_folder path
handles.default_data_Folder = default_data_Folder;
guidata(hObject, handles);

% open neutral data
neutral_dir = strcat(neutral_path, au_name);
neutral = load(neutral_dir);
au_point = regexp(au_name, '_', 'split');
au_point = au_point(1);

set(handles.editAU, 'String', au_point);

% set length of array (size of neutral)
length_neut = size(neutral, 1);
% disp(length_neut)

%% select a data file

% this is auto call
% get file directory

general_path_parts = regexp(default_data_Folder, '\', 'split');
length = size(general_path_parts, 2);
general_path = [];

for i = 1:length-2
    general_path = strcat(general_path, ...
    general_path_parts(i), '\');
end

file_dir = dir(char(general_path));
file_num = size(file_dir, 1)-1;

name = file_dir(4).name;
name = regexp(name, '_', 'split');
name = name(1);

set(handles.editName, 'String', name);

% initialize array
data_array = [];

% emotion lists
emotion = cell(1, file_num-3);

% starting reading data files
j = 3;

for i = 3:file_num
    
    % read folder name
    current_file = file_dir(i).name;
    current_emotion = regexp(current_file, '_', 'split');
    current_emotion = current_emotion(2);
       
    % check if neutral
    % if not neutral, perform
    if(~strcmp(current_emotion,'neutral'))
        
        % add current emotion to emotion_list
        emotion(j-2) = current_emotion;
        
        % get AU
        file_path =  strcat(general_path, current_file);
        current_data = Data_sorting(au_point, char(file_path));
        current_data = current_data(1:length_neut, :);
        data_array = cat(3, data_array, current_data);
        
        j =  j+1;
        
    end

end

% make neutral/emotion data as handle objects
handles.neutral = neutral;
guidata(hObject, handles);
handles.data_array = data_array;
guidata(hObject, handles);

% convert neutral/emotion data to catertian coordinate data
[neutral_x neutral_y] = trans_cp(neutral);
length = size(data_array, 3);
data_x = [];
data_y = [];

for i = 1:length
    [current_x current_y] = trans_cp(data_array(:,:,i));
    data_x = cat(3, data_x, current_x);
    data_y = cat(3, data_y, current_y);
end

% make catertian coordinate data as handle objects
handles.data_x = data_x;
guidata(hObject, handles);
handles.data_y = data_y;
guidata(hObject, handles);

handles.neutral_x = neutral_x;
guidata(hObject, handles);
handles.neutral_y = neutral_y;
guidata(hObject, handles);

% updata emotions
set(handles.emotion_pop, 'String', emotion);

%% plot

% reset file numbers
file_num = file_num-3;

% length of time = length of neutral data
sampling_freq = 30;
time = 0:1/sampling_freq:10;
time = time(1:length_neut);

handles.time = time;
guidata(hObject, handles);

% curve colors
cc = hsv(file_num);

% curve structures
curves_radius   = zeros(length_neut, file_num+1);
curves_angle    = zeros(length_neut, file_num+1);
radius_animation= zeros(1, file_num+1);
angle_animation = zeros(1, file_num+1);
polar_animation = zeros(2, file_num+1);

figure(1)

subplot(2,1,1)
title('\Delta R vs. time')
curves_radius(1) = plot(time, neutral(:,1), 'k-');
hold on

for i = 1:file_num
    curves_radius(i+1) = ...
        plot(time, data_array(:,1,i), 'color', cc(i,:));
end

for i = 1:file_num
    radius_animation(i+1) = line(time(1), data_array(1,1,i), 'Marker', ...
        '.','MarkerSize', 20, 'Color', 'b');
    set(radius_animation(i+1), 'Color', cc(i,:))
    set(radius_animation(i+1), 'Visible', 'off')
end

radius_animation(1) = line(time(1), neutral(1,1), 'Marker', '.',...
        'MarkerSize', 20, 'Color', 'k');
    set(radius_animation(1), 'Visible', 'off')

hold off
xlabel('time (s)')
ylabel('\Delta R (no units)')
legend(['neutral', emotion], 0)

subplot(2,1,2)
title('\Delta ^{\circ} vs. time')
curves_angle(1) = plot(time, neutral(:,2), 'k-');
hold on

for i = 1:file_num
    curves_angle(i+1) = ...
        plot(time, data_array(:,2,i), 'color', cc(i,:));
end

for i = 1:file_num
    angle_animation(i+1) = line(time(1), data_array(1,2,i), 'Marker', ...
        '.','MarkerSize', 20, 'Color', 'b');
    set(angle_animation(i+1), 'Color', cc(i,:))
    set(angle_animation(i+1), 'Visible', 'off')
end

angle_animation(1) = line(time(1), neutral(1,2), 'Marker', '.',...
        'MarkerSize', 20, 'Color', 'k');
    set(angle_animation(1), 'Visible', 'off')

hold off
xlabel('time (s)')
ylabel('\Delta ^{\circ} (radian)')
legend(['neutral', emotion], 0)

figure(2)
title('polar animation')

radius_lim = ones(1,1000)*0.005;
angle = linspace(0, 2*pi, 1000);
polar(angle, radius_lim)

hold on

polar_animation(1) = polar([0 neutral(1,2)], [0 neutral(1,1)], 'k');
set(polar_animation(1), 'Marker', '.', 'MarkerSize', 20, 'Visible', 'off')

for i = 1:file_num
       
    polar_animation(i+1) = polar([0 data_array(1,2,i)],...
        [0 data_array(1,1,i)], 'k');
    set(polar_animation(i+1), 'Color', cc(i,:))
    set(polar_animation(i+1), ...
        'Marker', '.', 'MarkerSize', 20, 'Visible', 'off')

end

hold off
legend(['range' 'neutral' emotion], 0)

% set curves as handle objects
handles.curves_radius    = curves_radius;
guidata(hObject, handles);
handles.curves_angle     = curves_angle;
guidata(hObject, handles);
handles.radius_animation = radius_animation;
guidata(hObject, handles);
handles.angle_animation  = angle_animation;
guidata(hObject, handles);
handles.polar_animation  = polar_animation;
guidata(hObject, handles);

% --- Executes on button press in btn2.
function btn2_Callback(hObject, eventdata, handles)
% hObject    handle to btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editAU_Callback(hObject, eventdata, handles)
% hObject    handle to editAU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAU as text
%        str2double(get(hObject,'String')) returns contents of editAU as a double


% --- Executes during object creation, after setting all properties.
function editAU_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in emotion_pop.
function emotion_pop_Callback(hObject, eventdata, handles)
% hObject    handle to emotion_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns emotion_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from emotion_pop


% --- Executes during object creation, after setting all properties.
function emotion_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to emotion_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn6.
function btn6_Callback(hObject, eventdata, handles)
% hObject    handle to btn6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delay = input('type the delay per update for animation in ms: ');

% get handles of animations
radius_animation = handles.radius_animation;
angle_animation  = handles.angle_animation;
polar_animation  = handles.polar_animation;

% get handles of data
% catersian data
data_x = handles.data_x;
data_y = handles.data_y;
neutral_x = handles.neutral_x;
neutral_y = handles.neutral_y;

% get para vs. time data
neutral = handles.neutral;
data_array = handles.data_array;

% get time data
time = handles.time;

% get save button value
save = get(handles.btn2, 'Value');

% turn on animations
% radius
set(radius_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'on')
set(radius_animation(1), 'Visible', 'on')

% angle
set(angle_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'on')
set(angle_animation(1), 'Visible', 'on')

% polar
set(polar_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'on')
set(polar_animation(1), 'Visible', 'on')

% do animation
length = size(time, 2);

% preallocate figure memory
% get figure size
% Get figure size

if save == 1
    movegui(figure(1))
    maximize(figure(1))
    movegui(figure(2))
    maximize(figure(2))
end

pos_1 = get(figure(1), 'Position');
pos_2 = get(figure(2), 'Position');
width_1 = pos_1(3);
height_1 = pos_1(4);
width_2 = pos_2(3);
height_2 = pos_2(4);

% Preallocate data (for storing frame data)
mov1 = zeros(height_1, width_1, 1, length, 'uint8');
mov2 = zeros(height_2, width_2, 1, length, 'uint8');

for i = 1:length
    pause(delay/1000);
    % polar
    % Update graphics data. This is more efficient than recreating plots.
    % neutral
    set(polar_animation(1),'XData',[0 neutral_x(i)],'YData',...
        [0 neutral_y(i)]);

    % selected emotion
    set(polar_animation(get(handles.emotion_pop, 'Value')+1), 'XData', ...
        [0 data_x(i)], 'YData', [0 data_y(i)])
    
    if save == 1
        % Get frame as an image
        f1 = getframe(figure(1));
    end
    
    % radius
    % Update graphics data. This is more efficient than recreating plots.
    % neutral
    set(radius_animation(1),'XData',time(i),'YData', neutral(i,1));

    % selected emotion
    set(radius_animation(get(handles.emotion_pop, 'Value')+1), 'XData', ...
        time(i), 'YData', data_array(i,1,...
        get(handles.emotion_pop, 'Value')))
    
    % angle
    % Update graphics data. This is more efficient than recreating plots.
    % neutral
    set(angle_animation(1),'XData',time(i),'YData', neutral(i,2));

    % selected emotion
    set(angle_animation(get(handles.emotion_pop, 'Value')+1), 'XData', ...
        time(i), 'YData', data_array(i,2,...
        get(handles.emotion_pop, 'Value')))
    
    if save == 1
        % Get frame as an image
        f2 = getframe(figure(2));
    end
    
    if (save == 1)
        if (i == 1)
            [mov1(:,:,1,i), map1] = rgb2ind(f1.cdata, 256, 'nodither');
            [mov2(:,:,1,i), map2] = rgb2ind(f2.cdata, 256, 'nodither');
        else
            mov1(:,:,1,i) = rgb2ind(f1.cdata, map1, 'nodither');
            mov2(:,:,1,i) = rgb2ind(f2.cdata, map2, 'nodither');
        end
    end
    
end

if (save == 1)
    % Create animated GIF
    save_path = uigetdir(pwd,'Open save directory');
    imwrite(mov1, map1, strcat(save_path, '\para.gif'), 'DelayTime', 0, 'LoopCount', inf) 
    imwrite(mov2, map2, strcat(save_path, '\polar.gif'), 'DelayTime', 0, 'LoopCount', inf)  
end

% turn off animations
% radius
set(radius_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'off')
set(radius_animation(1), 'Visible', 'off')

% angle
set(angle_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'off')
set(angle_animation(1), 'Visible', 'off')

% polar
set(polar_animation(get(handles.emotion_pop, 'Value')+1), ...
    'Visible', 'off')
set(polar_animation(1), 'Visible', 'off')

function editName_Callback(hObject, eventdata, handles)
% hObject    handle to editName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editName as text
%        str2double(get(hObject,'String')) returns contents of editName as a double


% --- Executes during object creation, after setting all properties.
function editName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in parameter_pop.
function parameter_pop_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns parameter_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameter_pop


% --- Executes during object creation, after setting all properties.
function parameter_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameter_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn3.
function btn3_Callback(hObject, eventdata, handles)
% hObject    handle to btn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get curve handles
curves_radius   = handles.curves_radius;
curves_angle    = handles.curves_angle;

% get selected graph/parameter/emotion
para_list = cellstr(get(handles.parameter_pop, 'String'));
para = para_list(get(handles.parameter_pop, 'Value'));

% set selected curve visible
if (strcmp(para, 'Radius'))
        set(curves_radius(get(handles.emotion_pop, 'Value')+1),...
            'Visible','on')
elseif (strcmp(para, 'Angle'))
            set(curves_angle(get(handles.emotion_pop, 'Value')+1),...
            'Visible','on')
end


% --- Executes on button press in btn4.
function btn4_Callback(hObject, eventdata, handles)
% hObject    handle to btn4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get curve handles
curves_radius   = handles.curves_radius;
curves_angle    = handles.curves_angle;

% get selected graph/parameter/emotion
para_list = cellstr(get(handles.parameter_pop, 'String'));
para = para_list(get(handles.parameter_pop, 'Value'));

% set selected curve visible
if (strcmp(para, 'Radius'))
        set(curves_radius(get(handles.emotion_pop, 'Value')+1),...
            'Visible','off')
elseif (strcmp(para, 'Angle'))
            set(curves_angle(get(handles.emotion_pop, 'Value')+1),...
            'Visible','off')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btn2.
function btn2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
