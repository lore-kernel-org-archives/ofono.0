Content-Type: multipart/mixed; boundary="===============2613123331211148652=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: ofono.service failure
Date: Sat, 04 May 2019 20:40:06 +1000
Message-ID: <CAA=hcWSby01t7ts1BHU+6R=QHU_NVo=Bc+dM24TGqB9X4GsxzA@mail.gmail.com>
In-Reply-To: <2c0b09e0-0cf3-4156-cfb3-33366ad857da@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2613123331211148652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Thanks for the response, actually ofonod was crashed during systemd
service, here is the log:

-- Logs begin at Fri 2019-05-03 01:00:52 UTC, end at Fri 2019-05-03
01:03:01 UTC. --
May 03 01:01:01 imx6ullevk systemd[1]: Starting Telephony service...
May 03 01:01:01 imx6ullevk ofonod[217]: oFono version 1.24
May 03 01:01:02 imx6ullevk systemd[1]: Started Telephony service.
May 03 01:01:05 imx6ullevk ofonod[217]: Aborting (signal 11) [/usr/sbin/ofo=
nod]
May 03 01:01:05 imx6ullevk systemd[1]: ofono.service: Main process
exited, code=3Dexited, status=3D1/FAILURE
May 03 01:01:05 imx6ullevk systemd[1]: ofono.service: Failed with
result 'exit-code'.

But I have no trouble to start the ofonod manually.

Thank you.

- jupiter


On 5/3/19, Jonas Bonn <jonas@norrbonn.se> wrote:
>
>
> On 02/05/2019 17:03, JH wrote:
>> Hi,
>>
>> The official ofono recipe ofono.inc defines SYSTEMD_SERVICE_${PN} =3D
>> "ofono.service", but the ofonod is not started by system service
>> automatically, I have to start the ofonod manually, what could be the
>> issue?
>
> This question should be directed to the OpenEmbedded mailing list as it
> has nothing to do with ofono, per se.
>
> That said:
> i)  it works for me on all recent versions of OE
> ii) including some relevant logging (journalctl, etc.) is generally
> helpful in debugging these matters; both the log of the ofono service,
> in case it fails to start due to crashes, and the log from systemd
> itself, in case systemd is deciding not to start the service for some
> reason.
>
> /Jonas
>
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jupiter
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>

--===============2613123331211148652==--

