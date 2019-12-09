Content-Type: multipart/mixed; boundary="===============0233425424938815066=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: How accuracy to get 4G LTE RSSI via connman dbus query?
Date: Tue, 10 Dec 2019 09:14:39 +1100
Message-ID: <CAA=hcWToewOAr6GoU4Egim8xq4mRg7MqFDr2xcqTREigbc9QdQ@mail.gmail.com>
In-Reply-To: <21c06978-3efe-6cb6-9d4a-94cc2354ba18@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0233425424938815066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 12/10/19, Jonas Bonn <jonas@norrbonn.se> wrote:
> Hi,
>
> On 09/12/2019 07:50, JH wrote:
>> Hi,
>>
>> I get 4G LTE RSSI from dbus connman service, I usually got about -61 I
>> thought it was accurate. But today, we are doing a test to check 4G LTE
>> RSSI based on different antennas, when connected to a antenna, the RSSI
>> is about -61, when I did not connect to an antenna, the RSSI =3D -40 but
>> the 4G LTE connection lost:
>>
>> kernel: qmi_wwan 1-1:1.3: nonzero urb status received: -71.
>
> Here your modem has probably crashed, right?

Right, I lost LTE connection at that time.

>>
>> Apparently that RSSI =3D -40 was wrong in the situation of without anten=
na
>> connection. I tried to build qmicli, but I could not get it running.
>> googling Internet, people pointed out, it could not be run if the qmi is
>> running by other services (ofono is running qmi on /dev/cdc-wdm0).
>>
>> # qmicli --nas-get-signal-strength --device=3D/dev/cdc-wdm0
>> error: couldn't create client for the 'nas' service: CID allocation
>> failed in the CTL client: Transaction timed out
>
> Just make sure ofono is stopped before running ofono.
>
> # systemctl stop ofono

Hmm, that is too difficult to use qmicli, it is not practical to stop
ofono every time. Are there any workarounds without stopping ofono?

Googling internet, followed suggestion to use qmi-proxy, but I still
could not get that work either:

# qmicli -p --nas-get-signal-strength --device=3D/dev/cdc-wdm0
error: couldn't open the QmiDevice: Couldn't spawn the qmi-proxy

The qmicli seems showing complete different values, but  it did make
sense than the values from connman dbus query:

[/dev/cdc-wdm0] Successfully got signal strength
Current:
        Network 'none': '-128 dBm'
RSSI:
        Network 'none': '-128 dBm'
ECIO:
        Network 'none': '-2.5 dBm'
IO: '-106 dBm'
SINR (8): '9.0 dB'

So RSSI from comman dbus query was false, right?

What is the normal methods you guys to measure the 4G LTE signaling strengt=
h?

Thank you very much Jonas,

Kind regards,

- jh
--===============0233425424938815066==--

