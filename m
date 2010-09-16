Content-Type: multipart/mixed; boundary="===============4415475481045959288=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 0/5] USSD fixes
Date: Thu, 16 Sep 2010 20:32:44 +0300
Message-ID: <1284658369-1988-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4415475481045959288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I've updated the isimodem ussd implementation to allow network-initiated
operations. I've added some debug logging to the core ussd, too.

The isimodem ussd now works with simple USSD applications with
puSS-Request and uSS-Requests, but uSS-Notifys while a mobile-originated
puSS-Request is pending seem not to work properly.

--Pekka


--===============4415475481045959288==--

