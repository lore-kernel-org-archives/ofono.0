Content-Type: multipart/mixed; boundary="===============0016049614852743928=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: vendor-specific shared functions
Date: Wed, 10 Oct 2018 10:09:57 +0200
Message-ID: <CAKSBH7FQNkfV7SXiDgLp964xYs+8GCY-mBUyj4awU-AfpZ7H4g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0016049614852743928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

I have a question for shared functions among atoms, but vendor-specific.

For Gemalto, I have these two for now:

gboolean gemalto_get_auth_command(struct ofono_modem *modem, int cid,
enum ofono_gprs_auth_method auth_method,
const char *username, const char *password,
char *buf, guint buflen);

void gemalto_get_cgdcont_command(struct ofono_modem *modem,
guint cid, enum ofono_gprs_proto proto, const char *apn,
char *buf, guint buflen);

that will be used by gprs-context and lte atoms.

I saw that also uBlox might benefit from the same shared functions,
because they prepend "PAP:" or "CHAP:" to the APN name if the
authentication is used.
For other vendors I don't know because the specifications are not
public, but there are loads of URC-parsing functions, sometimes
already duplicated.

I would like to set my functions in atmodem/utils.c, with headers in
atmodem/utils.h.
But maybe it is better to use atmodem/vendor.h and create an atmodem/vendor=
.c ?
Or duplicate them?

Any suggestion is appreciated.

thank you,
Regards,
Giacinto

--===============0016049614852743928==--

