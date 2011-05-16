Content-Type: multipart/mixed; boundary="===============6236712106265857399=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Adding New contact failed in Ofono
Date: Sun, 15 May 2011 21:27:03 -0500
Message-ID: <4DD08B77.6050505@gmail.com>
In-Reply-To: <BANLkTi=v=FFGF5n7m28Z+pj8J2pHr8jAcw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6236712106265857399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuvi,

On 05/16/2011 02:28 AM, Yuvaraj Ragupathi wrote:
> Hi All,
> =

> I am trying to add new contact in sim via following sample code
> =

> =

> static  int new_contact(struct ofono_phonebook *pb,char
> *num,ofono_phonebook_cb_t cb)
> {
>     struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
>     char cmd[50];int return_value;
>         sprintf(cmd,"AT+CPBW=3D10,%s,129,Testing", num);
>         printf("Command is %s\n",cmd);
>     return_value=3Dg_at_chat_send(pbd->chat,cmd, none_prefix,
>                        NULL,NULL, NULL);
>         printf("Add New contact number in Sim\n Status is
> %d\n",return_value);
>         return return_value;
> }
> =


oFono core does not support adding new contacts to the sim and there are
no plans to do so.  So I'm not quite sure what you're trying to
accomplish here in the first place.  If your question is about using
GAtChat, then adjust your subject accordingly.

> =

> If i try to add new contact  my Return status is  69 or 70
> =


Your 'return status' is just an ID assigned by GAtChat.  GAtChat is
_asynchronous_, your command has not been executed yet.  If you want to
know the result of the operation, provide a proper callback, or at the
very least enable AT debug logging.  See HACKING for details.

Regards,
-Denis

--===============6236712106265857399==--

