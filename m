Content-Type: multipart/mixed; boundary="===============2192577394075082237=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Description of Voice call history plugin patch
Date: Sat, 18 Sep 2010 08:41:13 +0900
Message-ID: <1284766873.2405.229.camel@localhost.localdomain>
In-Reply-To: <E1A1564674E5754FB00AB9AC949D5E3260C826D380@rrsmsx501.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2192577394075082237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> > Callhistory is a plugin loaded by ofono for persisting voice call histo=
ry information in a disk file. Plugin exports dbus methods and signals as o=
rg.ofono.callhistory interface. Whenever there is a voice call in the syste=
m, ofono calls the plugin with the infomation (lineid,calltype,start time, =
end time) , plugin writes the information into the file , increments the 'u=
nread' field in the header and sends out dbus signal with the number of unr=
ead records. Client (dialer) requests history records by calling method "Ge=
tVoiceHistory" exposed on the callhistory interface. After receiving inform=
ation client calls the "SetVoiceHistoryRead" as an acknowledgement to indic=
ate end of transaction. The pointers in the header are adjusted appropriate=
ly (explained clearly below).
> > =

> > Design : Plugin uses memory mapped file for high performance input/outp=
ut operations. File is used as cyclic queue for storing or reading records,=
 it store s 50 records of 78bytes,hence fixed size file of 3916 bytes is us=
ed. File's first 16 bytes were used for storing header, and next 3900 bytes=
 for data. Header structure has head pointer, tail pointer,unread and lasti=
d. Head pointer points to next slot for writing record into,tail for readin=
g record, unread for number of history records unread by client, lastid for=
 id of the last record that is written.
> =

> I am not buying into this performance argument at all. How many calls to
> you expect per second.
> =

> Raji >> Even if there are not many calls, operating system takes care of =
flushing the file to disk if there is any ofono crash. =


what is the difference of calling msync() compared to fdatasync() here.
I highly doubt that we have any issue in either case. A Linux IO and
filesystem expert could answer this, but in the end both of them end in
IO activity. And once you write to it you need to sync to ensure they
are actually written to disk.

This is also not really direkt IO vs memory mapped file. I couldn't care
less in the end. However this is about the complexity that is needed for
maintaining a round-robin file. I am failing to see the need for it.
 =

> > When the plugin is loaded by the ofono, it opens or creates a disk file=
 of 3916 bytes size and maps it into fixed size memory space. Plugin reads =
the header of the file , if the 'unread' records is > 0 , a signal is sent =
out on the dbus with the information of number of unread records. =

> > =

> > Requesting data by client: =

> > When the client calls "GetVoiceHistory" method,plugin uses temp_tail an=
d temp_unread variables to accomplish sending data to client. It copies tai=
l pointer stored in the header into temporary tail pointer ,starts to read =
history records one at a time from the location pointed by the temp tail po=
inter , copies the into dbus structure, increments the temp tail pointer by=
 size of the history record (78 bytes) and reads data from the next record =
location , this is repeated until it reaches head pointer. when all the unr=
ead records are read then the dbus structure is sent to the client. Once th=
e data received, client needs to "SetVoiceHistoryRead" method to indicate t=
hat it received the data. Plugin will update the tail pointer with the temp=
 tail pointer and unread records number is decremented by temp_unread. Usin=
g temp_tail and temp_unread variables protect from modifying the header if =
there is any loss in data delivery. If client doesnt call 'SetVoiceHistoryR=
ead' then the act
>  ua
> >  l header pointers wont be updated in the file. =

> > =

> > Writing record into the file:
> > When Ofono calls the plugin with call information (phone number, call t=
ype, call start time , call end time), plugin increaments the lastid to cre=
ate record id for this record ,writes the record in the location pointed by=
 head, and the head pointer is incremented by size of record (78 bytes), "u=
nread" variable is incremented by 1. If the head reaches end of file (3916)=
 then it is reset it back to begining of the data portion of the file (16 b=
ytes). A dbus signal is sent out with number of current unread records. Plu=
gin keeps writing the records in circular queue.
> =

> This sounds all way too complicated. And the D-Bus API design is
> actually racy since there is no clear access control on the history
> information.
> =

> I think the proper solution is to create a call history plugin that
> creates a D-Bus interface for a call history agent.
> =

> That way we know when an agent is present to consume history information
> and only if none is present we have to cache it on disk. And once an
> agent becomes available flush the cached information.
> =

> And the cache should be just be done with a simply appending to a file
> and then truncating it after reading it.
> =

> Raji >> Marcel, James Ketrenos discussed this design with you back in apr=
il. I will send you the thread on that. I was under impression that you bot=
h agreed on this design.

Just get one thing straight here. Design is design and implementation is
something totally different.

If we use a memory mapped file aside, the whole D-Bus API is pretty much
racy in my eyes since you can not track the history consumer application
use. You don't know when it is running or not. You don't know what to
cache or not. You can not handle crashing of the history consumer
application.

This current implementation is rather complicated to what it is suppose
to achieve. We have two things here, one is the general questions about
on how the D-Bus API of this should actually work. And second about your
current implementation.

The current API has limitations as listed above. These needs to be
addressed and clear way forward seems an agent based model.

The implementation has some flaws. For starters the locking that you
still haven't explained why it is correct. And I agree with Denis here
that I don't see what it is doing. Second is the file system format that
can't work properly on different architectures. You need to use properly
sized variable and ensure the structures memory layout is the same. I
even forgot to mention big endian vs little endian.

Without these fixed, I am not even considering this for upstream.

Regards

Marcel



--===============2192577394075082237==--

