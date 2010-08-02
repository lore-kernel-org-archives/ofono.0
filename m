Content-Type: multipart/mixed; boundary="===============4281489999382187522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] Fix busylooped in ppp_disconnect for huawei modem
Date: Mon, 02 Aug 2010 14:13:56 -0500
Message-ID: <4C5718F4.8040001@gmail.com>
In-Reply-To: <1280276726-17360-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4281489999382187522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 07/27/2010 07:25 PM, Zhenhua Zhang wrote:
> Huawei modem closes the modem port after PPP disconnect. So the channel
> of gatchat is NULL in ppp_disconnect. In such case, we resume the chat
> and it causes huawei_disconnect() get called and the gprs context is
> removed later.
> =

> Before removing this gprs context, we should reply the pending DBus
> message to the client.
> ---

Since V2 was reported to work I went ahead and applied this version.
Thanks for the fix.

Regards,
-Denis

--===============4281489999382187522==--

