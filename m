Content-Type: multipart/mixed; boundary="===============4928578255318164449=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-nofify-v4 PATCH 0/3] ofono_sim_ready_notify()
Date: Wed, 12 Jan 2011 22:06:20 +0200
Message-ID: <1294862783-1979-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4928578255318164449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is my 5th stab at the ofono_sim_ready_notify().

The main difference to the patches submitted 16th December last year is
that the isimodem sim driver has been refactored to the new SIM API. The
AT modem driver and core has been rebased to current master, too.

The ofono_sim_ready_notify() is now always expected after call to
query_passwd_state.

When ofono_sim_ready_notify() is invoked, it checks that the call is
expected and if needed, retries the query_passwd_state, otherwise it
proceeds with sim initialization.

The patches has now been tested with the PIN and PUK codes with mbm, ifx
on NCDK and with N900 using Jukka's new isimodem sim driver.

--Pekka


--===============4928578255318164449==--

