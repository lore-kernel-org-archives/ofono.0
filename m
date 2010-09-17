Content-Type: multipart/mixed; boundary="===============2126266549816680650=="
MIME-Version: 1.0
From: Rajyalakshmi Bommaraju <Rajyalakshmi.Bommaraju@intel.com>
Subject: Description of Voice call history plugin patch
Date: Thu, 16 Sep 2010 17:13:06 -0700
Message-ID: <1284682387-22768-1-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2126266549816680650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

							Call History Plugin =


Introduction:
Callhistory is a plugin loaded by ofono for persisting voice call history i=
nformation in a disk file. Plugin exports dbus methods and signals as org.o=
fono.callhistory interface. Whenever there is a voice call in the system, o=
fono calls the plugin with the infomation (lineid,calltype,start time, end =
time) , plugin writes the information into the file , increments the 'unrea=
d' field in the header and sends out dbus signal with the number of unread =
records. Client (dialer) requests history records by calling method "GetVoi=
ceHistory" exposed on the callhistory interface. After receiving informatio=
n client calls the "SetVoiceHistoryRead" as an acknowledgement to indicate =
end of transaction. The pointers in the header are adjusted appropriately (=
explained clearly below).

Design : Plugin uses memory mapped file for high performance input/output o=
perations. File is used as cyclic queue for storing or reading records, it =
store s 50 records of 78bytes,hence fixed size file of 3916 bytes is used. =
File's first 16 bytes were used for storing header, and next 3900 bytes for=
 data. Header structure has head pointer, tail pointer,unread and lastid. H=
ead pointer points to next slot for writing record into,tail for reading re=
cord, unread for number of history records unread by client, lastid for id =
of the last record that is written.

Below is the file structure: (3916 bytes)

|Header|Data| =

0     16

Header Structure: (16 bytes)

|head|tail|unread|lastid|
0    4    8      12     16


head : Points to next slot for writing

tail : Points to next record to be read

unread : Number of Unread records so far

lastid : Number of the record that is last written =



Below is the structure of the history record:
History Record:(78 bytes)

|id|lineid|calltype|start time|end time|

id : Record id

lineid : phone Number

calltype : Outgoing/Incoming/Missed =


start time: start time in UTC

end time: end time in UTC

 =

When the plugin is loaded by the ofono, it opens or creates a disk file of =
3916 bytes size and maps it into fixed size memory space. Plugin reads the =
header of the file , if the 'unread' records is > 0 , a signal is sent out =
on the dbus with the information of number of unread records. =


Requesting data by client: =

When the client calls "GetVoiceHistory" method,plugin uses temp_tail and te=
mp_unread variables to accomplish sending data to client. It copies tail po=
inter stored in the header into temporary tail pointer ,starts to read hist=
ory records one at a time from the location pointed by the temp tail pointe=
r , copies the into dbus structure, increments the temp tail pointer by siz=
e of the history record (78 bytes) and reads data from the next record loca=
tion , this is repeated until it reaches head pointer. when all the unread =
records are read then the dbus structure is sent to the client. Once the da=
ta received, client needs to "SetVoiceHistoryRead" method to indicate that =
it received the data. Plugin will update the tail pointer with the temp tai=
l pointer and unread records number is decremented by temp_unread. Using te=
mp_tail and temp_unread variables protect from modifying the header if ther=
e is any loss in data delivery. If client doesnt call 'SetVoiceHistoryRead'=
 then the actual header pointers wont be updated in the file. =


Writing record into the file:
When Ofono calls the plugin with call information (phone number, call type,=
 call start time , call end time), plugin increaments the lastid to create =
record id for this record ,writes the record in the location pointed by hea=
d, and the head pointer is incremented by size of record (78 bytes), "unrea=
d" variable is incremented by 1. If the head reaches end of file (3916) the=
n it is reset it back to begining of the data portion of the file (16 bytes=
). A dbus signal is sent out with number of current unread records. Plugin =
keeps writing the records in circular queue.

Locking: =

Accessing Memory mapped file pointer , all header fields (head,tail,unread,=
lastid), temp_unread,temp_tail are synchronized by a mutex. writing into me=
mory file and reading from memory file happen asynchronously, so mutex is u=
sed to protect the memory mapped file pointer , header, temp_unread, temp_t=
ail.

Limitations:
History is limited to storing 50 records. The above design assumes that the=
re is only one client (either dialer or a history daemon) that reads data a=
nd sends acknowledgemnts.=20

--===============2126266549816680650==--

