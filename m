Content-Type: multipart/mixed; boundary="===============1133810856794362287=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 1/3] bluez5: Add bt_register_profile_full()
Date: Tue, 23 Apr 2013 11:29:11 -0300
Message-ID: <20130423142911.GA11434@samus>
In-Reply-To: <51764A7C.6050008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1133810856794362287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03:46 Tue 23 Apr, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 04/22/2013 12:54 PM, Vinicius Costa Gomes wrote:
> >This function makes it easy to set up optional information in the profile
> >service record.
> >---
> >  plugins/bluez5.c | 40 +++++++++++++++++++++++++++++++++-------
> >  plugins/bluez5.h | 10 ++++++++++
> >  2 files changed, 43 insertions(+), 7 deletions(-)
> >
> >diff --git a/plugins/bluez5.c b/plugins/bluez5.c
> >index 0f997da..48d8bf2 100644
> >--- a/plugins/bluez5.c
> >+++ b/plugins/bluez5.c
> >@@ -90,9 +90,10 @@ done:
> >  	dbus_message_unref(reply);
> >  }
> >
> >-int bt_register_profile_with_role(DBusConnection *conn, const char *uui=
d,
> >-					uint16_t version, const char *name,
> >-					const char *object, const char *role)
> >+int bt_register_profile_full(DBusConnection *conn,
> >+					const char *uuid, uint16_t version,
> >+					const char *name, const char *object,
> >+					struct bt_profile_info *optional)
> =

> We are now getting too many variations.  We currently have 4 callers
> of bt_register_profile (3 the simple function, 1 of _role).  Now we
> have 4 callers and 3 variations.  This is too much.  Lets just make
> bt_register_profile accept the full set of arguments and change
> everyone over.
> =

> Also, I don't like introducing a struct bt_profile_info for this.
> Just add the extra arguments you need and accept NULL where needed.

Fair enough.  Sure.


Sure.
-- =

Vinicius

--===============1133810856794362287==--

