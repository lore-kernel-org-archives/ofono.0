Content-Type: multipart/mixed; boundary="===============0738859965521473271=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: huawei: network attachment unstability
Date: Mon, 22 Oct 2018 18:57:52 +0200
Message-ID: <CAKSBH7Fm3bLuXX90bCMogNR_DE3OMCZe84D4u8dcNj3XmBHQkQ@mail.gmail.com>
In-Reply-To: <4e85a76e-f698-5638-9dff-09b0b0b456c6@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0738859965521473271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Mon, Oct 22, 2018 at 5:33 PM Christophe Ronco <c.ronco@kerlink.fr> wro=
te:
>
> Hi,
>
> I (sometimes) use a huawei USB key named MS2372h-153.
> With this key, I am sometimes unable to connect. When this happens, here
> is what I have in traces:
>
> t0) Attached to WCDMA network
> t1) Switch to LTE network
> t1+xs) Attachment loss reported
> t1+(x+2)s) Attached to WCDMA network
> t2) Switch to LTE network
> t2) Attachment loss reported
> t2+2s) Attached to WCDMA network

I think it is a problem with the logic of ofono. I have pushed a patch
or two removing AT+CGATT and mentioning that AT+CGATT is evil for LTE
modules, but was rejected.
However Denis asked for a trace, that at the moment I cannot produce
with a branch of ofono close to the one upstream with the modules I
have, but it seems you have managed.

> ....
>
> So I am not able to have a stable network attachment. This does not
> happen if I have a direct attach to LTE network. In this case, I have a
> stable connection.
>
> I don't know why this key systematically reports a network detach when
> switching from WCDMA to LTE. But I also don't understand why Ofono sends
> a AT+CGATT=3D0 each time detach is reported and AT+CGATT=3D1 each time
> network attachment is back.
>
> I tried to remove the call to gprs->driver->set_attached in
> gprs_netreg_update (src/gprs.c). When problem occurs, with this patch I
> have:
> t0) Attached to WCDMA network
> t1) Switch to LTE network
> t1+xs) Attachment loss reported
> t1+(x+2)s) Attached to LTE network
>
> And then I have a stable connection.
>
> I tried to find where this call come from and traced it back to a very
> old commit:
> commit f43efa8a5f24f2aab71f829082cc02a272268986
> Author: Andrzej Zaborowski <andrew.zaborowski@intel.com>
> Date:   Mon Oct 12 23:35:59 2009 +0200
>
> Please find with this mail two files with Ofono complete traces of the
> problem (in ofonoTraces.tar.gz):
> attachmentLossLoop.txt:
> Oct 22 09:44:35: Attached WCDMA
> Oct 22 09:48:41: switch to LTE
> Oct 22 09:48:53: loosing network
> Oct 22 09:48:53: AT+CGATT=3D0
> Oct 22 09:48:55: Attached WCDMA
> Oct 22 09:48:55: AT+CGATT=3D1
> Oct 22 09:48:58: switch to LTE
> Oct 22 09:48:58: loosing network
> Oct 22 09:48:58: AT+CGATT=3D0
> Oct 22 09:49:12: Attached WCDMA
> ...
>
> attachmentOkWithoutCGATT.txt:
> Oct 22 14:04:58: WCDMA connection
> Oct 22 14:05:23: switch to LTE
> Oct 22 14:05:35: loosing network
> Oct 22 14:05:36: attached back, directly on LTE
>
> My question is: why does ofono core ask driver to detach from PS domain
> when network attachment is lost?
>
> Best Regards,
>
> Christophe Ronco
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Regards.
Giacinto

--===============0738859965521473271==--

