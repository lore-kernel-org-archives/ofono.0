Content-Type: multipart/mixed; boundary="===============8522600777432460615=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/6] lte-api: protocol and authentication properties
Date: Thu, 11 Oct 2018 21:07:06 +0200
Message-ID: <32e78673-6aaa-25b8-8919-f004d483f851@southpole.se>
In-Reply-To: <20181010065454.15232-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8522600777432460615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

Reading through your patches, I'm missing an overarching explanation of =

why we need this.=C2=A0 Do you really have an LTE network in range that =

requires authentication for the default APN?=C2=A0 What happens if =

authentication fails... are you connected to an alternative APN =

automatically, with other service parameters? What indication is =

available to the user if authentication fails?

/Jonas


On 10/10/18 08:54, Giacinto Cifelli wrote:
> added 4 properties for handling the type of context and the
> authentication method, exactly like in any gprs context handling.
> The properties are named after the equivalent gprs-context one, for
> compatibility and uniformity.
> ---
>   doc/lte-api.txt | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/doc/lte-api.txt b/doc/lte-api.txt
> index 8a2a97d9..e9cbba0a 100644
> --- a/doc/lte-api.txt
> +++ b/doc/lte-api.txt
> @@ -33,3 +33,37 @@ Properties	string DefaultAccessPointName [readwrite]
>   =

>   			Setting this property to an empty string clears the
>   			default APN from the modem.
> +
> +		string Protocol [readwrite]
> +
> +			Holds the protocol for this context.  Valid values
> +			are: "ip", "ipv6" and "dual". Default value is "ip".
> +
> +		string AuthenticationMethod [readwrite]
> +
> +			Sets the Method used for the authentication
> +			for the default APN.
> +
> +			Available values are "none", "pap" and "chap".
> +			Default is "none".
> +
> +			If the AuthenticationMethod is set to 'none' it remove
> +			the authentication for the DefaultAPN.
> +			In case of AuthenticationMethod 'none',
> +			if the Username and Password properties are not empty,
> +			the values are preserved in the properties, but they
> +			are not used or transmitted to the module.
> +			Conversely, if Username or Password are empty, the
> +			authentication method selected internally is 'none',
> +			but the property AuthenticationMethod is left unchanged.
> +
> +		string Username [readwrite]
> +
> +			Holds the username to be used for authentication
> +			purposes.
> +
> +		string Password [readwrite]
> +
> +			Holds the password to be used for authentication
> +			purposes.
> +


--===============8522600777432460615==--

