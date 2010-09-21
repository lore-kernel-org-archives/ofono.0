Content-Type: multipart/mixed; boundary="===============1810519128843062040=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: SMS History
Date: Tue, 21 Sep 2010 08:53:34 -0500
Message-ID: <4C98B8DE.4040400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1810519128843062040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

I just pushed a set of changes to the SMS atom that affects SMS history
internal API.  Instead of using a revolving unsigned int id for unique
SMS message identifiers we now use an SHA1 based hash id.  This should
solve some long-standing issues with identifier not being updated
properly on hard resets, etc.

As a result, any pending status reports after upgrading the oFono
version will become unusable and should be scrubbed.  E.g. any directory
in /var/lib/ofono/<imsi>/sms_sr should to be removed.

Regards,
-Denis

--===============1810519128843062040==--

