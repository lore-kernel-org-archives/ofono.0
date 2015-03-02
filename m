Content-Type: multipart/mixed; boundary="===============7362690161201295960=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Receiving raw SMS through Ofono "incoming-message" callback
Date: Mon, 02 Mar 2015 09:18:43 -0600
Message-ID: <54F47F53.4090508@gmail.com>
In-Reply-To: <CAEM=xjhdg0CV2FqurNzmrqSAaWjr4ui=na+tqmTtvGrDa8Q2Eg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7362690161201295960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederik,

On 03/02/2015 05:45 AM, Frederik Lotter wrote:
> Hi,
>
> It looks like the SMS receive API attempts to represent the incoming SMS
> as an array of characters inside the callback function.
>
> IncomingMessage(string message, dict info)

This API is for 'text' messages.  It will not handle non-utf8 formatted =

strings and will ignore any IEs that are not pertinent to decoding text =

messages.

>
> I am expecting a raw payload of server data via SMS. I cannot see how
> this will work in the current implementation since the raw data may well
> be full of zeros which will act as a string terminator.
>
> Any ideas?
>

You can write a plugin for this.  For example, see =

plugins/smart-messaging.c and plugins/push-notification.c

Regards,
-Denis

--===============7362690161201295960==--

