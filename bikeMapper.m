cityname = input("city (lowercase; replace spaces with underscores)?\n", 's');
html = urlread("https://share.veoride.com/api/share/gbfs/free_bike_status?area_name="+cityname); 
html = strsplit(html, '{')';

time = string(html{2});
time = strsplit(time, ',');
time = extractAfter(time{1}, 15);

html(~startsWith(html, '"bike_id"')) = [];
html = string(html);
html = repmat(html, 1, 3);
for i = 1:size(html, 1)
    toBeSplit = strsplit(html(i, 1), ',');
    html(i, 1) = extractAfter(toBeSplit(1), 10);
    html(i, 2) = extractAfter(toBeSplit(2), 6);
    html(i, 3) = extractAfter(toBeSplit(3), 6);
end
html = table(html(:, 1), html(:, 2), html(:, 3), 'VariableNames', {'id', 'lat', 'long'});
if size(html, 1) > 0
    html.lat = str2double(html.lat);
    html.long = str2double(html.long);
    geobubble(html.lat, html.long, .5)
else
    disp("no data on city");
end