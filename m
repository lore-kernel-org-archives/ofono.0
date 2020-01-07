Content-Type: multipart/mixed; boundary="===============6128471722535603076=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: connman settings for modem APN
Date: Tue, 07 Jan 2020 18:05:26 +0100
Message-ID: <3268003d-87c8-77f5-75e6-99f82bbb7c78@monom.org>
In-Reply-To: <CABPh3UMvrJHZoGSNTvvWCNCOHH4jKZ44XcF+3EeD8zxL+CaikQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6128471722535603076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 07.01.20 17:38, nick83ola wrote:
> I have to manage a modem with connman through dbus and I'm willing to
> work on the ofono plugin to add the APN handling but I'm not familiar
> with connman code.
> =

> Connman is already creating a ofono internet context by default for
> the modem but it doesn't offer the possibility to configure the APN
> (and user/password) for the connection.

Correct.

> Where you would put the dbus method to set the APN for a particular
> connection? =


See oFono documentation on Connection Context.

> I would prefer if possible only to connect to connman not
> connman/ofono.

/*
  * The way this plugin works is following:
  *
  *   powered -> SubscriberIdentity or Online =3D True -> gprs, context ->
  *     attached -> netreg -> ready
  *
  * Depending on the modem type, this plugin will behave differently.
  *
  * GSM working flow:
  *
  * When a new modem appears, the plugin always powers it up. This
  * allows the plugin to create a connman_device. The core will call
  * modem_enable() if the technology is enabled. modem_enable() will
  * then set the modem online. If the technology is disabled then
  * modem_disable() will just set the modem offline. The modem is
  * always kept powered all the time.
  *
  * After setting the modem online the plugin waits for the
  * ConnectionManager and ConnectionContext to appear. When the context
  * signals that it is attached and the NetworkRegistration interface
  * appears, a new Service will be created and registered at the core.
  *
  * When asked to connect to the network (network_connect()) the plugin
  * will set the Active property on the context. If this operation is
  * successful the modem is connected to the network. oFono will inform
  * the plugin about IP configuration through the updating the context's
  * properties.
[...]

I have only a vague memory on this topic, but I think to remember that =

oFono will only show the CM if the APN was provisioned in oFono. Maybe I =

have false memory on it.

Thanks,
Daniel
--===============6128471722535603076==--

