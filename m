Content-Type: multipart/mixed; boundary="===============7978673505677542807=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: Timeout/Reliability issue with my plugin
Date: Sat, 12 Mar 2016 15:03:49 +0000
Message-ID: <loom.20160312T152722-352@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7978673505677542807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,                                                                        =
     =

                                                                           =
     =

my plugin is opening the serial on _enable and on _disable it is issuing a =
     =

AT+CFUN=3D0 and waits for the result before discarding the atchat.         =
       =

                                                                           =
     =

$ ./tests/enable-modem /wavecom_0                                          =
     =

...                                                                        =
     =

$ lsof | grep ttyUSB0 | wc -l                                              =
     =

1                                                                          =
     =

                                                                           =
     =

$ ./tests/disable-modem /wavecom_0                                         =
     =

$ lsof | grep ttyUSB0 | wc -l                                              =
     =

0                                                                          =
     =

                                                                           =
     =

So far so good. But if I run the above in a loop.. then I see dbus timeouts=
 and =

when I execute lsof.. I see that ofonod has 1023 FDs open. So at some point=
 in  =

time either the state is messed up or the AT+CFUN doesn't respond.. but we =
open =

the same device more than once.                                            =
     =

                                                                           =
     =

Is this known? Does ofono start timers? Does the GAtChat have a way to time=
out  =

commands and then disclose it? How do other modems handle such situation?  =
     =

                                                                           =
     =

kind regards                                                               =
     =

  holger   =



--===============7978673505677542807==--

