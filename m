Content-Type: multipart/mixed; boundary="===============4253369358618918612=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: huawei e1550
Date: Wed, 13 Oct 2010 15:14:51 +0300
Message-ID: <8739sae1c4.fsf@potku.valot.fi>
In-Reply-To: <1286970609.10204.3.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4253369358618918612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alexander A Khryukin <alexander@mezon.ru> writes:

>> Sorry, I wasn't able to immeadiately say from the logs what went wrong.
>> Can you get a log which includes AT commands? It would help a lot.
>> =

>> Just run this command to get the logs:
>> =

>> OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n
>> =

>> What's the exact version of ofono you are using? Huawei has had some
>> changes lately. =

>> =

>> Also is the SIM configured to ask for PIN or not? I'm guessing no from
>> the log, but can't be sure.
>
> Ok.I connect modem to usb-port, and log it
>
> OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n

Sorry, I forgot -d switch from the command which enables the debug
messages. So it should be like this:

OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n -d

> http://pastie.org/1212535

I didn't immeadiately find anything wrong in the AT logs. So basically
your modem disappers from the bus and then comes back. Can a firmware
crash cause that?

The last commands were:

ofonod[838]: PCUI: > AT+CSCB=3D1\r
ofonod[838]: PCUI: < \r\nOK\r\n
ofonod[838]: PCUI: > AT+CSCB=3D0,"4096,4097,4098,4099,4100,4101,4102,4103,4=
104,4105,4106,4107,4108,4109,4110,4111,4352-4356"\r

Can you try the patch below? Maybe it gives us some hint what's
happening.

diff --git a/plugins/huawei.c b/plugins/huawei.c
index b20d83c..13ef192 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -624,8 +624,6 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
                                                                data->pcui);
 =

        ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
-       ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-                                               "atmodem", data->pcui);
        ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
                                                "atmodem", data->pcui);

--===============4253369358618918612==--

