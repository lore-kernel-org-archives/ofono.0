Content-Type: multipart/mixed; boundary="===============0216979587025792299=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Description of Voice call history plugin patch
Date: Fri, 17 Sep 2010 17:07:09 +0900
Message-ID: <1284710829.2405.183.camel@localhost.localdomain>
In-Reply-To: <E1A1564674E5754FB00AB9AC949D5E3260C826D076@rrsmsx501.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0216979587025792299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> > Design : Plugin uses memory mapped file for high performance input/outp=
ut operations. File is used as cyclic queue for storing or reading records,=
 it store s 50 records of 78bytes,hence fixed size file of 3916 bytes is us=
ed. File's first 16 bytes were used for storing header, and next 3900 bytes=
 for data. Header structure has head pointer, tail pointer,unread and lasti=
d. Head pointer points to next slot for writing record into,tail for readin=
g record, unread for number of history records unread by client, lastid for=
 id of the last record that is written.
> =

> Just a couple quick points.  Memory mapped files do not really give any
> benefit over read/write/lseek for small files (e.g. less than a few
> pages) with small record sizes (e.g. less than a 4K page.)  In fact
> they're probably slower in these cases.
> =

> > Locking: =

> > Accessing Memory mapped file pointer , all header fields (head,tail,unr=
ead,lastid), temp_unread,temp_tail are synchronized by a mutex. writing int=
o memory file and reading from memory file happen asynchronously, so mutex =
is used to protect the memory mapped file pointer , header, temp_unread, te=
mp_tail.
> =

> I'm totally confused by this one; you use no threads in your plugin (and
> neither does oFono) and you have no external clients accessing the same
> shared memory region.  It seems to me that locking is completely
> unnecessary.
> =

> Raji > History reads are client driven, can happen during the write opera=
tion. Same with writing, if there is any read operation in progress, write =
operation needs to wait. So the mutex will lock the memory information unti=
l read/write operation is done. =


who reads from this file. The mutex is local to ofonod. If any other
program reads from that memory you need a proper memory lock. The local
mutex is not helping since ofonod is (on purpose) single threaded and
thus no locking is actually needed since read and write operations from
ofonod can't happen at the same time.

Regards

Marcel



--===============0216979587025792299==--

