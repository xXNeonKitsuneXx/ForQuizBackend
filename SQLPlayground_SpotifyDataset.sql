Select * from lv1_tracks;
SELECT * from lv1_tracks limit 10;
select name, album, artist from lv1_tracks;
select name, album, artist from lv1_tracks limit 10;
select* from lv1_tracks order by name;
select* from lv1_tracks order by name desc;
select* from lv1_tracks order by name;
select* from lv1_tracks order by name desc;
SELECT * from lv1_tracks order by name desc limit 10;
Select * from lv1_tracks where duration > 200000;
Select * from lv1_tracks where duration > 200000 order by name;
Select * from lv1_tracks where duration > 200000 and duration < 300000;
Select * from lv1_tracks where duration > 200000 and duration < 300000 order by name;
Select * from lv1_tracks where duration > 280000 and duration < 300000 order by name desc;
Select * from lv1_tracks where duration > 280000 and duration < 300000 order by name desc limit 10;
Select * from lv1_tracks where duration > 200000 and duration < 350000 and year = 2020 order by name desc limit 10 offset 3;
Select * from lv1_tracks where popularity >= 40 and explicit = 1;

#
Select name as "track_name" from lv1_tracks limit 10;
SELECT * from lv1_tracks WHERE name LIKE 'A%';
SELECT * from lv1_tracks WHERE name LIKE 'A%' or name LIKE 'j%';
SELECT * from lv1_tracks WHERE name LIKE '%A%';
SELECT name, LOWER(name) FROM lv1_tracks;
#
# interesting case--------------------------------------
SELECT * from lv1_tracks WHERE name LIKE '%A%';
SELECT * from lv1_tracks WHERE LOWER(name) LIKE '%a%';
# ----------------------------------------------------------
#
SELECT * FROM lv1_tracks WHERE LOWER(name) LIKE '%the%' OR LOWER(album) LIKE '%the%' OR LOWER(artist) LIKE '%the%';
#
SELECT name as track_name, duration as track_duration from lv1_tracks LIMIT 10;
#
# ---------------------------------------------------------------------------------------------------------------------------------------------
select name as track_name, id ,spotify_id, name, album, artist, artwork_url, duration, popularity, explicit, year, count from lv1_tracks;
SELECT name AS track_name, lv1_tracks.* FROM lv1_tracks;
# what if I want name out of lv1_track.* ---> here is ANS [still error
# SELECT name as track_name, * EXCEPT (name) FROM lv1_tracks;
#-----------------------------------------------------------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------------------------------------------
SELECT MIN(year) FROM lv1_tracks;
select * from lv1_tracks where year = (select min(year) from lv1_tracks);
# Above code is select all song that in min(year)
#---------------------------------------------------------------------------------------------------------------------------------
#
SELECT MIN(year), MAX(year) FROM lv1_tracks;
SELECT MIN(year) as oldest_year, MAX(year) as newest_year FROM lv1_tracks;
select COUNT(*) from lv1_tracks;
select COUNT(*) as total_tracks from lv1_tracks;
#
# ---------------------------------------------------------------------------------------------------------
SELECT COUNT(*) FROM lv1_tracks GROUP BY year;
SELECT year, COUNT(*) AS total_tracks FROM lv1_tracks GROUP BY year;
# Above code is show year
#-------------------------------------------------------------------------------------------------------
#
SELECT COUNT(*) as total_tracks FROM lv1_tracks GROUP BY year;
#
# ------------------------------------------------------------------------------------------------
SELECT SUM(duration) AS total_duration FROM lv1_tracks GROUP BY year;
SELECT year, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY year;
# Above code is show year
# ------------------------------------------------------------------------------------------
#
SELECT year, COUNT(*) AS total_tracks FROM lv1_tracks GROUP BY year ORDER BY total_tracks desc, year ASC;
SELECT CONCAT(name, ' - ', artist) AS display_name FROM lv1_tracks LIMIT 10;
#
#
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT year, COUNT(*) AS total_tracks, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY year ORDER BY total_tracks DESC, CASE WHEN year THEN total_duration END ASC;
SELECT year, COUNT(*) AS total_tracks, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY year ORDER BY total_tracks DESC,
         CASE
             WHEN COUNT(*) = 1 THEN MIN(duration)
             ELSE SUM(duration) / COUNT(*)
         END ASC;
SELECT year, COUNT(*) AS total_tracks, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY year ORDER BY total_tracks DESC, total_duration ASC;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#
SELECT artist, COUNT(*) AS total_tracks, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY artist ORDER BY total_tracks;
SELECT artist, album, COUNT(*) AS total_tracks, SUM(duration) AS total_duration FROM lv1_tracks GROUP BY artist, album ORDER BY total_tracks;
SELECT album, COUNT(*) AS total_tracks, AVG(duration) AS average_duration FROM lv1_tracks GROUP BY album ORDER BY average_duration;
#
# EX Format 4 in Training --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT album, (SELECT COUNT(*) FROM lv1_tracks t1 WHERE t1.album = lv1_tracks.album AND t1.explicit = 1) AS explicit_tracks_count, (SELECT COUNT(*) FROM lv1_tracks t2 WHERE t2.album = lv1_tracks.album) AS total_tracks, (SELECT COUNT(*) FROM lv1_tracks t3 WHERE t3.album = lv1_tracks.album AND t3.explicit = 1) / (SELECT COUNT(*) FROM lv1_tracks t4 WHERE t4.album = lv1_tracks.album) AS explicit_percentage FROM lv1_tracks GROUP BY album ORDER BY explicit_percentage;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# EX Format 5 in Training ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT year, (SELECT artist FROM lv1_tracks WHERE year = lv1_tracks.year GROUP BY artist ORDER BY COUNT(*) DESC LIMIT 1) AS top_artist_name_by_track_count FROM lv1_tracks GROUP BY year ORDER BY 'year';
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
select * from lv2_tracks;
select * from lv2_tracks limit 1;
select album_id from lv2_tracks limit 1;
SELECT * FROM lv2_albums WHERE lv2_albums.id = (SELECT album_id FROM lv2_tracks LIMIT 1);
SELECT * FROM lv2_tracks WHERE album_id = (SELECT album_id FROM lv2_tracks LIMIT 1);
#
SELECT lv2_tracks.name, lv2_albums.name FROM lv2_tracks JOIN lv2_albums ON lv2_tracks.album_id = lv2_albums.id;
#
SELECT lv2_tracks.name, lv2_albums.name FROM lv2_tracks JOIN lv2_albums ON lv2_tracks.album_id = lv2_albums.id WHERE lv2_tracks.name LIKE 'A%';
#
SELECT lv2_tracks.name, lv2_albums.name, lv2_artists.name FROM lv2_tracks JOIN lv2_albums ON lv2_tracks.album_id = lv2_albums.id JOIN lv2_artists ON lv2_albums.artist_id = lv2_artists.id;
#
SELECT * FROM lv2_albums JOIN lv2_tracks ON lv2_tracks.album_id = lv2_albums.id;
#
SELECT CONCAT(lv2_tracks.name, ' - ', lv2_albums.name) FROM lv2_tracks JOIN lv2_albums ON lv2_tracks.album_id = lv2_albums.id;
#
SELECT CONCAT(lv2_tracks.name) AS tracks FROM lv2_albums JOIN lv2_tracks ON lv2_tracks.album_id = lv2_albums.id;
#
SELECT SUM(lv2_tracks.duration) FROM lv2_albums JOIN lv2_tracks ON lv2_tracks.album_id = lv2_albums.id;
#
SELECT SUM(lv2_tracks.duration) FROM lv2_artists JOIN lv2_albums ON lv2_albums.artist_id = lv2_artists.id JOIN lv2_tracks ON lv2_tracks.album_id = lv2_albums.id ORDER BY SUM(lv2_tracks.duration);


