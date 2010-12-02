Content-Type: multipart/mixed; boundary="===============7130188410266366899=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 02 Dec 2010 18:16:19 +0200
Message-ID: <1291306582-19024-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7130188410266366899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Currently, if GPRS service is detached for whatever reason, the only way
to get PS services back is to set the Powered property to FALSE and back
to TRUE.

With these patches, GPRS context activation will cause oFono to
automatically attempt GPRS attach if the modem is presently detached.

Br,

	MikaL

[PATCH 1/3] gprs: attach on demand
[PATCH 2/3] gprs: update documentation
[PATCH 3/3] isimodem: context activation might follow attach

--===============7130188410266366899==--

