Content-Type: multipart/mixed; boundary="===============2847113261148102905=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: RE: How to get the OMA DRM right object file coming from WAP Push?
Date: Thu, 25 Nov 2010 11:07:05 +0200
Message-ID: <1290676025.5365.24.camel@tucson>
In-Reply-To: <749B9D3DBF0F054390025D9EAFF47F223023B247@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2847113261148102905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-11-25 at 14:15 +0800, ext Lin, Mengdong wrote:

> Can the two methods help me to handle files from WAP  push?

Yes. You need to implement the PushNotificationAgent interface, and
register this object with oFono using the RegisterAgent() method.

Cheers,
Aki



--===============2847113261148102905==--

