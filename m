Content-Type: multipart/mixed; boundary="===============6252334199286612386=="
MIME-Version: 1.0
From: Bommaraju, Rajyalakshmi <rajyalakshmi.bommaraju@intel.com>
Subject: RE: Description of Voice call history plugin patch
Date: Fri, 17 Sep 2010 00:32:43 -0600
Message-ID: <E1A1564674E5754FB00AB9AC949D5E3260C826D076@rrsmsx501.amr.corp.intel.com>
In-Reply-To: <4C92DDB0.8010101@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6252334199286612386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Thanks for the feedback, I have given explanation for locking below.

Thanks,
Raji
-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Thursday, September 16, 2010 8:17 PM
To: ofono(a)ofono.org
Cc: Bommaraju, Rajyalakshmi
Subject: Re: Description of Voice call history plugin patch

Hi Raji,

> Design : Plugin uses memory mapped file for high performance input/output=
 operations. File is used as cyclic queue for storing or reading records, i=
t store s 50 records of 78bytes,hence fixed size file of 3916 bytes is used=
. File's first 16 bytes were used for storing header, and next 3900 bytes f=
or data. Header structure has head pointer, tail pointer,unread and lastid.=
 Head pointer points to next slot for writing record into,tail for reading =
record, unread for number of history records unread by client, lastid for i=
d of the last record that is written.

Just a couple quick points.  Memory mapped files do not really give any
benefit over read/write/lseek for small files (e.g. less than a few
pages) with small record sizes (e.g. less than a 4K page.)  In fact
they're probably slower in these cases.

> Locking: =

> Accessing Memory mapped file pointer , all header fields (head,tail,unrea=
d,lastid), temp_unread,temp_tail are synchronized by a mutex. writing into =
memory file and reading from memory file happen asynchronously, so mutex is=
 used to protect the memory mapped file pointer , header, temp_unread, temp=
_tail.

I'm totally confused by this one; you use no threads in your plugin (and
neither does oFono) and you have no external clients accessing the same
shared memory region.  It seems to me that locking is completely
unnecessary.

Raji > History reads are client driven, can happen during the write operati=
on. Same with writing, if there is any read operation in progress, write op=
eration needs to wait. So the mutex will lock the memory information until =
read/write operation is done.=20

--===============6252334199286612386==--

