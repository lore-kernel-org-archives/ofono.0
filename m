Content-Type: multipart/mixed; boundary="===============4816447896132517262=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Wierd behaviour of ofono on MC7455 and Verizon sim card
Date: Thu, 08 Mar 2018 11:55:45 -0600
Message-ID: <7e109768-30ae-de91-2acf-7de5a23db3e0@gmail.com>
In-Reply-To: <4fed9df5a18d4bcebbb8cae4c4861605@de.bosch.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4816447896132517262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/08/2018 11:47 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: ../ofono-1.22/drivers/qmimodem=
/devinfo.c:string_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: ../ofono-1.22/drivers/qmimodem=
/devinfo.c:qmi_query_serial()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: ../ofono-1.22/drivers/qmimodem=
/sim.c:get_card_status_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]: ../ofono-1.22/src/sim.c:ofono_=
sim_add_state_watch() 0x198d658

You would have to check the logic inside get_card_status_cb() to figure =

out why the sim isn't being detected.

Regards,
-Denis

--===============4816447896132517262==--

