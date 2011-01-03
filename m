Content-Type: multipart/mixed; boundary="===============4929314936091520411=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-authenticate PATCH 0/3]
Date: Mon, 03 Jan 2011 16:58:18 +0200
Message-ID: <1294066701-27298-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4929314936091520411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is first proposal for SIM authentication API.  The API provides
access to ordinary SIM authentication methods.  The first two methods
are intended for implementing EAP authentication using cellular
authentication mechanisms, the third one for implementing AKA
authentication algorithm used with IMS.

There can be special EAP application implementing EAP protocol and using
secrets and authentication methods separate from cellular authentication
on SIM card; it is not handled here.

I have no clear idea how the GBA authentication should be used, I'll add
that later.

--Pekka


--===============4929314936091520411==--

