Content-Type: multipart/mixed; boundary="===============5111490178189002458=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Tue, 01 Dec 2020 20:56:33 +1100
Message-ID: <CAA=hcWTO8Xfb7RCJKvkcWmhRpENMuN++LZhrNdmS8Ecxkd=meQ@mail.gmail.com>
In-Reply-To: <22165064-45d2-6542-f014-47b8a33b9c4a@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5111490178189002458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

Thanks for the response.

> I agree with Jonas to say that all the magic is in ss_info_notify. At lea=
st that's the case outside LTE, I don't know a lot about LTE specificities.

Any idea how to modify the source to get ss_info_notify running in
qmimodem The question is how to do it? Adding
qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND, ss_info_notify,
netreg, NULL); to ss_info_notify network-registration.c just not
working.

> When you restart Ofono, radio stack of the modem will be reset
> (something like AT+CFUN=3D4, AT+CFUN=3D0 happens), that's why a new data
> registration process occurs.

You are right, restarting ofono is to reset modem, I can also run SARA
modem power reset via GPIO to bring the register back as well.

> I don't know if you have access to an AT channel or another QMI channel
> on your modem while Ofono is running. If this is the case, you could ask
> for registration status while ofono is running using AT commands or
> using qmicli. Let me know if you can do that and don't know the commands
> to do it.

Yes, there are two ports, /dev/ttyUSB0 is for QMI control,
/dev/ttyUSB1 is for AT, QMI modem does not use it. Yes, I can run AT
commands manually in the command line to get responses from
/dev/ttyUSB1.

Thank you.

Kind regards,

- j
--===============5111490178189002458==--

