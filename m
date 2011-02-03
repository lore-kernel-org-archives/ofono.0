Content-Type: multipart/mixed; boundary="===============6209295222060599929=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 0/6] Add alphabet support to SMS
Date: Thu, 03 Feb 2011 15:20:30 +0200
Message-ID: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6209295222060599929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is a set resurrected from last year, adding support for different
GSM alphabets or dialects when sending SMSs.

The first two patches do some refactoring that allows buidling also
custom GSM alphabets such as a combination of single shift and locking
shift tables of different GSM alphabet dialects, or even completely
custom conversion tables such as one that transliterates a range of
unicode to the default GSM alphabet.

The current algorithm for picking an optimal encoding, however, only
uses tables from a single dialect.

Cheers,
Aki


--===============6209295222060599929==--

