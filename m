Content-Type: multipart/mixed; boundary="===============6149033563606140090=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Telit HE910 modem --- unable be put on line by Connman
Date: Mon, 03 Dec 2012 09:32:04 +0100
Message-ID: <50BC6384.3080705@monom.org>
In-Reply-To: <50B8D36B.1070305@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6149033563606140090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mingli,


On 30.11.2012 16:40, Ming Li Wu wrote:
> Hello,
>
> I am working on Telit HE910 modem.
>
> I am using ofono 1.11, and the commit is
> 6e3a6156b34c52bde253b097976d0ba9dd575879.
>
> For the Telit modem, "AT+CFUN=3D4" is used to enable
> the modem. According to "Telit He910 AT Commands
> Reference Guide", "issuing AT+CFUN=3D4[,0] actually
> causes the module to perform either a network
> deregistration and a SIM deactivation."

Is rfkill enabled?

cheers,
daniel

--===============6149033563606140090==--

