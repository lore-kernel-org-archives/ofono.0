Content-Type: multipart/mixed; boundary="===============6358750953463870308=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v3] Fix busylooped in ppp_disconnect for huawei modem
Date: Wed, 04 Aug 2010 15:54:48 +0300
Message-ID: <87k4o6wnaf.fsf@potku.valot.fi>
In-Reply-To: <4C5718F4.8040001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6358750953463870308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Zhenhua,
>
> On 07/27/2010 07:25 PM, Zhenhua Zhang wrote:
>> Huawei modem closes the modem port after PPP disconnect. So the channel
>> of gatchat is NULL in ppp_disconnect. In such case, we resume the chat
>> and it causes huawei_disconnect() get called and the gprs context is
>> removed later.
>> =

>> Before removing this gprs context, we should reply the pending DBus
>> message to the client.
>> ---
>
> Since V2 was reported to work I went ahead and applied this version.
> Thanks for the fix.

I quickly tested current git (which should contain this patch) with
Huawei E1552 and ofono doesn't crash anymore. But now ofono doesn't
connect after a few rounds of connect, disconnect, connect, disconnect
testing. I need to unplug and plug in my modem to get it working again.

I don't know if this patch caused the regression or not.

-- =

Kalle Valo

--===============6358750953463870308==--

