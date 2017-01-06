Content-Type: multipart/mixed; boundary="===============6932516719883630475=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] MC7430: add read_imsi feature to qmimodem sim driver
Date: Fri, 06 Jan 2017 10:41:40 -0600
Message-ID: <f7d8bab5-f944-1b49-d20e-3f09fd11be6d@gmail.com>
In-Reply-To: <55c5a5dc-f7d1-f698-0426-101bb5d9e927@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6932516719883630475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

>> This worked on a bunch of QMI based devices, so I have to assume that
>> this fails on Sierra?  If so, then this probably should be quirked to
>> be Sierra-specific behavior.  E.g. via a mechanism similar to
>> drivers/atmodem/vendor.h
> IMSI reading on my MC7430 modem do fail without this patch.
> I have the following traces in this case:
> Jan  5 11:08:41 klk-lpbs_040070 daemon.debug ofonod[869]:
> ../ofono-1.19/drivers/qmimodem/sim.c:qmi_read_transparent() file id
> 0x6f07 path len 0
> Jan  5 11:08:41 klk-lpbs_040070 daemon.debug ofonod[869]:
> ../ofono-1.19/drivers/qmimodem/sim.c:read_generic_cb()
> Jan  5 11:08:41 klk-lpbs_040070 daemon.err ofonod[869]: Unable to read
> IMSI, emergency calls only

Do any reads from the SIM succeed on the sierra devices?  Perhaps they =

need a different set of magic than what is currently implemented?  I =

know we tested this on Huawei and a few other vendors and reading the =

IMSI via qmi_read_transparent worked fine.

>>
>> ofono_sim_remove will call .remove method.  So this is likely to cause
>> a crash since uim and dms have already been unref-ed.
> OK, I have not tested this error case. The
> "qmi_service_unref(data->uim)" that's here in this function without the
> patch must cause the same crash.
>

It probably is a bug as well, yes.

Regards,
-Denis

--===============6932516719883630475==--

