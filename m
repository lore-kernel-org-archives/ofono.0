Content-Type: multipart/mixed; boundary="===============4900017003896876341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Description of Voice call history plugin patch
Date: Thu, 16 Sep 2010 22:17:04 -0500
Message-ID: <4C92DDB0.8010101@gmail.com>
In-Reply-To: <1284682387-22768-1-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4900017003896876341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Am I missing something here?

Regards,
-Denis

--===============4900017003896876341==--

