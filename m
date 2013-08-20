Content-Type: multipart/mixed; boundary="===============5142634865585267380=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 6/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Tue, 20 Aug 2013 16:51:33 +0300
Message-ID: <CABBYNZK4XhtKnM2nyZ7jFkjVQ1Bi_nVB=DxOeN7GMrq-CX9VSA@mail.gmail.com>
In-Reply-To: <20130819184735.GB3075@molly.profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5142634865585267380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On Mon, Aug 19, 2013 at 9:47 PM, Vinicius Costa Gomes <vcgomes@gmail.com>=
 wrote:
> Hi Denis,
>
> On 12:57 Mon 19 Aug, Denis Kenzior wrote:
>> Hi Vinicius,
>>
>> On 08/15/2013 09:26 PM, Vinicius Costa Gomes wrote:
>> >There's nothing we can do in this case, so we only reply with a
>> >success.
>> >---
>> >  plugins/hfp_hf_bluez5.c | 4 +---
>> >  1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> >diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
>> >index 7e98a45..391a74e 100644
>> >--- a/plugins/hfp_hf_bluez5.c
>> >+++ b/plugins/hfp_hf_bluez5.c
>> >@@ -564,9 +564,7 @@ static DBusMessage *profile_release(DBusConnection =
*conn,
>> >  {
>> >     DBG("Profile handler Release");
>> >
>> >-    return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
>> >-                                            ".NotImplemented",
>> >-                                            "Implementation not provid=
ed");
>> >+    return dbus_message_new_method_return(msg);
>>
>> To me it seems like this method is not properly labeled as NOREPLY
>> inside the BlueZ API specification.  Sending a reply here seems
>> pointless.
>
> I agree. Going to fix, and send a patch to BlueZ to add that label.

While at it you might consider actually handling the Release because
right now oFono doesn't react to either org.bluez disappearing nor
adapter proxy being removed so if one of those events happen without
calling RequestDisconnection oFono will keep the connection.

Before anyone asks, there is another difference between Release and
RequestDisconnection, the former should cause a forceful disconnect if
connected while the latter should disconnect gracefully so bluetoothd
will wait for the response so in theory Release can happen without
RequestDisconnection being called before.


-- =

Luiz Augusto von Dentz

--===============5142634865585267380==--

