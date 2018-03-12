Content-Type: multipart/mixed; boundary="===============0111019110893811834=="
MIME-Version: 1.0
From: Eswaran Vinothkumar (BEG/PJ-IOT-EL) <Vinothkumar.Eswaran@de.bosch.com>
Subject: AW: Wierd behaviour of ofono on MC7455 and Verizon sim card
Date: Mon, 12 Mar 2018 13:46:27 +0000
Message-ID: <c727c03648ce4e698bfe88169dc68f5a@de.bosch.com>
In-Reply-To: <7e109768-30ae-de91-2acf-7de5a23db3e0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0111019110893811834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/08/2018 11:47 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
> Mar 08 17:14:51 alen-eval-kit ofonod[175]:
> ../ofono-1.22/drivers/qmimodem/devinfo.c:string_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]:
> ../ofono-1.22/drivers/qmimodem/devinfo.c:qmi_query_serial()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]:
> ../ofono-1.22/drivers/qmimodem/sim.c:get_card_status_cb()
> Mar 08 17:14:51 alen-eval-kit ofonod[175]:
> ../ofono-1.22/src/sim.c:ofono_sim_add_state_watch() 0x198d658

You would have to check the logic inside get_card_status_cb() to figure out=
 why the sim isn't being detected.

Hi,

Thanks for the hint. I looked into the source code of ofono and had identif=
ied the condition on which the sim card detection logic fails.

The function handle_get_card_status_result() returns failure.  The Verizon =
SIM I used has 4 application running. The output of qmicli is shown below:

# qmicli -d /dev/cdc-wdm1 --uim-get-card-status
[/dev/cdc-wdm1] Successfully got card status
Provisioning applications:
        Primary GW:   slot '0', application '2'
        Primary 1X:   slot '0', application '0'
        Secondary GW: session doesn't exist
        Secondary 1X: session doesn't exist
Card [0]:
        Card state: 'present'
        UPIN state: 'not-initialized'
                UPIN retries: '0'
                UPUK retries: '0'
        Application [0]:
                Application type:  'csim (4)'
                Application state: 'ready'
                Application ID:
                        A0:00:00:03:43:10:02:F3:10:FF:FF:89:02:00:00:FF
                Personalization state: 'ready'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'disabled'
                        PIN1 retries: '3'
                        PUK1 retries: '10'
                PIN2 state: 'enabled-not-verified'
                        PIN2 retries: '3'
                        PUK2 retries: '10'
        Application [1]:
                Application type:  'isim (5)'
                Application state: 'detected'
                Application ID:
                        A0:00:00:00:87:10:04:F3:10:FF:FF:89:08:00:00:FF
                Personalization state: 'unknown'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'not-initialized'
                        PIN1 retries: '0'
                        PUK1 retries: '0'
                PIN2 state: 'not-initialized'
                        PIN2 retries: '0'
                        PUK2 retries: '0'
        Application [2]:
                Application type:  'usim (2)'
                Application state: 'ready'
                Application ID:
                        A0:00:00:00:87:10:02:F3:10:FF:FF:89:08:00:00:FF
                Personalization state: 'ready'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'disabled'
                        PIN1 retries: '3'
                        PUK1 retries: '10'
                PIN2 state: 'enabled-not-verified'
                        PIN2 retries: '3'
                        PUK2 retries: '10'
        Application [3]:
                Application type:  'unknown (0)'
                Application state: 'detected'
                Application ID:
                        A0:00:00:00:63:50:4B:43:53:2D:31:35
                Personalization state: 'unknown'
                UPIN replaces PIN1: 'no'
                PIN1 state: 'not-initialized'
                        PIN1 retries: '0'
                        PUK1 retries: '0'
                PIN2 state: 'not-initialized'
                        PIN2 retries: '0'
                        PUK2 retries: '0'


The sim detection logic fails in the condition :

                        if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D =
n) {
                                if (get_card_status(slot, info1, info2,sim_=
stat))
                                {
                                        res =3D GET_CARD_STATUS_RESULT_TEMP=
_ERROR;
                                }
                                else
                                {
                                                res =3D GET_CARD_STATUS_RES=
ULT_OK;
                                }
                        }

In the condition check the slot number and application number is interchang=
ed. After fixing this, I could see that ofono is successfully detecting the=
 sim cards.

I will send a patch in my next e-mail

Regards,
-Denis

--===============0111019110893811834==--

