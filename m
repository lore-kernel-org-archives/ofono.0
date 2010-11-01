Content-Type: multipart/mixed; boundary="===============4675613110965763332=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: File Structure for persisting history in a disk file (Comments please)
Date: Mon, 01 Nov 2010 12:06:59 -0700
Message-ID: <4CCF0FD3.9050705@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4675613110965763332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I want to use the following file structure for persisting history in a =

disk file. Can you please send me your feedback about it.

Thanks
Raji Bommaraju

                                            _File structure for History =

Persistance_

History information will be stored in a disk file. The file will have a =

File Header consisting of "Bytes Stored" and "Head" for writing the next =

record.Each record stored will have record header and record data, =

record header has "record type" and "size of the record" (For Text =

messages the records will have variable length message data resulting in =

variable length records) hence this record structure is used.

*File Format:*

|File Header| Data |


File Header (8 bytes):

|Bytes stored | Head|
0                    4        8

*Data:*

|Record|Record|.....etc

*Record:*

|Record Header|Actual data|

*Record Header:*
Record Type: 1byte (voice call history - 0, text history- 1)
Size : Integer

Actual data: Will be voice call or text message information


--===============4675613110965763332==--

