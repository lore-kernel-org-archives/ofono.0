Content-Type: multipart/mixed; boundary="===============5331439526291058654=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [ANNOUNCE] oFono v1.12 and GCF USAT testing status
Date: Wed, 19 Dec 2012 17:46:44 -0600
Message-ID: <50D251E4.8080307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5331439526291058654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Our long standing task is to get oFono ready to pass GCF/PTCRB =

certification.  One of the key areas of these certifications is USIM =

Application Toolkit (USAT).  In late November we took oFono to a =

GCF/PTCRB certified test laboratory to perform a baseline test run to =

understand how ready the oFono USAT implementation is.  We are happy to =

report that we have obtained an outstanding result.

The process took about a week and a half, during which time we ran a =

total of 248 test cases.  Not everything went smoothly, as is always the =

case.  We found several bugs and fixed them in real-time in the lab. =

Surprisingly, most were quite minor.  In the end we were able to pass =

all but 2 test cases.  This is a pass rate of 99.2%.  If you are =

interested in the detailed test report, the distilled version can be =

found in the oFono git repository under =

doc/usat-certification-status.txt.  Here is a direct link: =

http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Ddoc/usat-ce=
rtification-status.txt;hb=3DHEAD

The recently released oFono 1.12 incorporates all of the fixes from our =

test lab visit as well as several other improvements.  We believe that =

this is a significant accomplishment, and wish to send big Kudos to =

everyone involved, in particular: Andrzej Zaborowski, Yang Gu, Jeevaka =

Badrappan, Marcel Holtmann, Kristen Carlson Accardi and Philippe Nunes.

To everyone involved with the project: Thank you guys and Happy New Year!!!

Regards,
-Denis

--===============5331439526291058654==--

