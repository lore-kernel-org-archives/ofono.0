Content-Type: multipart/mixed; boundary="===============7087218133118138149=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Description of Voice call history plugin patch
Date: Fri, 17 Sep 2010 17:16:49 +0900
Message-ID: <1284711409.2405.192.camel@localhost.localdomain>
In-Reply-To: <1284682387-22768-1-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7087218133118138149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> Callhistory is a plugin loaded by ofono for persisting voice call history=
 information in a disk file. Plugin exports dbus methods and signals as org=
.ofono.callhistory interface. Whenever there is a voice call in the system,=
 ofono calls the plugin with the infomation (lineid,calltype,start time, en=
d time) , plugin writes the information into the file , increments the 'unr=
ead' field in the header and sends out dbus signal with the number of unrea=
d records. Client (dialer) requests history records by calling method "GetV=
oiceHistory" exposed on the callhistory interface. After receiving informat=
ion client calls the "SetVoiceHistoryRead" as an acknowledgement to indicat=
e end of transaction. The pointers in the header are adjusted appropriately=
 (explained clearly below).
> =

> Design : Plugin uses memory mapped file for high performance input/output=
 operations. File is used as cyclic queue for storing or reading records, i=
t store s 50 records of 78bytes,hence fixed size file of 3916 bytes is used=
. File's first 16 bytes were used for storing header, and next 3900 bytes f=
or data. Header structure has head pointer, tail pointer,unread and lastid.=
 Head pointer points to next slot for writing record into,tail for reading =
record, unread for number of history records unread by client, lastid for i=
d of the last record that is written.

I am not buying into this performance argument at all. How many calls to
you expect per second.
 =

> When the plugin is loaded by the ofono, it opens or creates a disk file o=
f 3916 bytes size and maps it into fixed size memory space. Plugin reads th=
e header of the file , if the 'unread' records is > 0 , a signal is sent ou=
t on the dbus with the information of number of unread records. =

> =

> Requesting data by client: =

> When the client calls "GetVoiceHistory" method,plugin uses temp_tail and =
temp_unread variables to accomplish sending data to client. It copies tail =
pointer stored in the header into temporary tail pointer ,starts to read hi=
story records one at a time from the location pointed by the temp tail poin=
ter , copies the into dbus structure, increments the temp tail pointer by s=
ize of the history record (78 bytes) and reads data from the next record lo=
cation , this is repeated until it reaches head pointer. when all the unrea=
d records are read then the dbus structure is sent to the client. Once the =
data received, client needs to "SetVoiceHistoryRead" method to indicate tha=
t it received the data. Plugin will update the tail pointer with the temp t=
ail pointer and unread records number is decremented by temp_unread. Using =
temp_tail and temp_unread variables protect from modifying the header if th=
ere is any loss in data delivery. If client doesnt call 'SetVoiceHistoryRea=
d' then the actua
>  l header pointers wont be updated in the file. =

> =

> Writing record into the file:
> When Ofono calls the plugin with call information (phone number, call typ=
e, call start time , call end time), plugin increaments the lastid to creat=
e record id for this record ,writes the record in the location pointed by h=
ead, and the head pointer is incremented by size of record (78 bytes), "unr=
ead" variable is incremented by 1. If the head reaches end of file (3916) t=
hen it is reset it back to begining of the data portion of the file (16 byt=
es). A dbus signal is sent out with number of current unread records. Plugi=
n keeps writing the records in circular queue.

This sounds all way too complicated. And the D-Bus API design is
actually racy since there is no clear access control on the history
information.

I think the proper solution is to create a call history plugin that
creates a D-Bus interface for a call history agent.

That way we know when an agent is present to consume history information
and only if none is present we have to cache it on disk. And once an
agent becomes available flush the cached information.

And the cache should be just be done with a simply appending to a file
and then truncating it after reading it.

Regards

Marcel



--===============7087218133118138149==--

