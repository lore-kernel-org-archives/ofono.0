Content-Type: multipart/mixed; boundary="===============3331547901854869192=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: Re: [PATCH 6/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Mon, 19 Aug 2013 15:47:35 -0300
Message-ID: <20130819184735.GB3075@molly.profusion.mobi>
In-Reply-To: <52125CA1.5020203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3331547901854869192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


On 12:57 Mon 19 Aug, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 08/15/2013 09:26 PM, Vinicius Costa Gomes wrote:
> >There's nothing we can do in this case, so we only reply with a
> >success.
> >---
> >  plugins/hfp_hf_bluez5.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> >diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> >index 7e98a45..391a74e 100644
> >--- a/plugins/hfp_hf_bluez5.c
> >+++ b/plugins/hfp_hf_bluez5.c
> >@@ -564,9 +564,7 @@ static DBusMessage *profile_release(DBusConnection *=
conn,
> >  {
> >  	DBG("Profile handler Release");
> >
> >-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
> >-						".NotImplemented",
> >-						"Implementation not provided");
> >+	return dbus_message_new_method_return(msg);
> =

> To me it seems like this method is not properly labeled as NOREPLY
> inside the BlueZ API specification.  Sending a reply here seems
> pointless.

I agree. Going to fix, and send a patch to BlueZ to add that label. =


> =

> >  }
> >
> >  static DBusMessage *profile_cancel(DBusConnection *conn,
> >
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============3331547901854869192==--

