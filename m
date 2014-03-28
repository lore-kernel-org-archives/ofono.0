Content-Type: multipart/mixed; boundary="===============1944793195835921241=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: wwan0 interface without IP
Date: Fri, 28 Mar 2014 12:41:23 +0100
Message-ID: <lh3n4k$a8i$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1944793195835921241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi !!

i'm back with my project using ofono/connman/sierra 3G modem...

now my modem work fine with ofono until connection. i can see IP =

address with ofono in debug mode (response from !SCPADDR command)
interface wwan0 is UP... but without IPV4 parameters.. (only MAC =

address)
i can't go to internet with this.

i have try to put connman in debug mode too, and get an error because =

IPAddress is not set.

at this time, if i start udhcpc -i wwan0... connection is made and work =

fine....

few seconds only after a very short time, connman say idle timeout and =

ofono goes offline.

i mean there is something wrong in ofono... (or connman ? don't know..)

someone can help me ?

thank you so much


--===============1944793195835921241==--

