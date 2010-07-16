Content-Type: multipart/mixed; boundary="===============4612939418676413125=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Porting the oFono to our HW platform
Date: Fri, 16 Jul 2010 17:49:03 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731F17D38E@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTinCoFnnOTFXCq8FPcu-GvjptIc-a4xnff6yH5T-@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4612939418676413125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, =



> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf Of Zheng Zhang
> Sent: Friday, July 16, 2010 4:05 PM
> To: ofono(a)ofono.org
> Subject: Porting the oFono to our HW platform
>
> Hi everyone, =

> I am studying the oFono, and maybe we have a future task to port the oFon=
o to our HW platform, so how much work we should do? And I have concerned t=
hat the task should cover ofono/drivers and ofono/plugins.
> Generally speaking, the CPU vender should help us for the ofono/drivers f=
or their own modems.And we will make the plugin works well between the oFon=
o Core and drivers.(Maybe the the main job is to populate the struct ofono_=
modem_driver) =

> Is my understanding correct? Thank you for your suggestions! =


It depends on what kind of modem you have, and how many features you want t=
o support. In general, to make oFono recognize your modem would not be very=
 hard, given that your modem driver (just hardware driver, not the ones in =
ofono/drivers directory) is ready. But if your modem is specific, most of e=
ffort would be paid in ofono/drivers directory. Otherwise, you may reuse ex=
ist AT driver or other drivers, and the whole workload would be trivial. =


Regards,
-Yang

--===============4612939418676413125==--

