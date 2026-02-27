Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3B229B38
	for <ofono@lists.linux.dev>; Fri, 27 Feb 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228233; cv=none; b=rbQwdVcHpaORzu7ubVkiUNJaWJYCuNWpltRvqjAsE4IxU1YsD0dvUupnNc6Xc8bUYoYTGxoVoOwaFIRoX+R+g1uuElK88ciR1/eQq4uithcL/Z/DaKSkOJgdxStW9FzdLZ1ZZP06c4XPbHTraT1dq9pvX0uriAoLNBZ3pabhr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228233; c=relaxed/simple;
	bh=ViqNcZRjZWfNRncK1lAjpAAFavg2N2EuLh4AIYuQK1E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=YTJQBiEQuQhFhtE4mBwRkAUNcqmmOhOJCZukWSMuikEvI2Hhs14C06TlHQIgTQpZ2EF7dHzJg225RtjP1wrNUp8t6MVUnmOHPf+U+kevpJ1xEeOo4QkJtH35zPAMPn0XqsvjeesEp1walTqmWdTLj/AQ3pCaXov0tI86VAyqSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id AC9811135CE; Fri, 27 Feb 2026 16:27:24 -0500 (EST)
Received: from [192.168.12.132] (unknown [172.56.160.155])
	by spindle.queued.net (Postfix) with ESMTPSA id DCE251134F1;
	Fri, 27 Feb 2026 16:27:22 -0500 (EST)
Message-ID: <a1bcc043-ead3-4486-a75e-7bdb79423b36@queued.net>
Date: Fri, 27 Feb 2026 16:27:21 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phonesim: fix exporting of child widgets to javascript
 engine
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
References: <20251229031053.1441ddc6@5400>
Content-Language: en-US
Autocrypt: addr=dilinger@queued.net; keydata=
 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
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20251229031053.1441ddc6@5400>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

BTW Marcel, I noticed in the latest phonesim release (2.1) that the 
tarball dropped the doc/scriptable.txt file. Was this unintentional, or 
is the javascript interface being deprecated?

If it's not being deprecated, I'd love some feedback on this patch. :)

On 12/29/25 03:10, Andres Salomon wrote:
> Using the example sms.js script in doc/scriptable.txt, the following
> error occurs with phonesim built using Qt5.15:
> 
> Error org.ofono.phonesim.Error.ScriptExecError: /tmp/sms.js, line 1, TypeError: Cannot read property 'leMessageSender' of undefined
> 
> This is due to phonesim creating javascript objects for all the gui
> tab widgets, but none of the child widgets inside of those tabs. So
> in the javascript engine, 'tabSMS' is available, but its child widget
> 'gbMessage1' is undefined.
> 
> I'm not sure if this is related to behavior changes in current versions
> of QJSEngine/UIC or what, but we can manually add all those widgets
> to the javascript engine to fix this.
> ---
>   src/control.cpp | 25 +++++++++++++++++++++++++
>   src/control.h   |  2 ++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/src/control.cpp b/src/control.cpp
> index 817a0b2..b85e9ad 100644
> --- a/src/control.cpp
> +++ b/src/control.cpp
> @@ -637,32 +637,57 @@ void ControlWidget::modemSilentReset()
>       emit unsolicitedCommand("+CRST:");
>   }
>   
> +/*
> + * Recursively add all widgets in a controlbase.ui tab to the javascript
> + * engine so that scripts can reference them. Because the widgets
> + * aren't local to this function, they should remain in scope while the
> + * script executes.
> + */
> +void Script::AddChildren(const QWidget *parentW, QJSValue &parentJS)
> +{
> +    QList<QWidget*> kids = parentW->findChildren<QWidget*>(QString(),
> +            Qt::FindDirectChildrenOnly);
> +    foreach (QWidget *w, kids) {
> +        QJSValue obj = engine.newQObject(w);
> +        parentJS.setProperty(w->objectName(), obj);
> +        AddChildren(w, obj);
> +    }
> +}
> +
>   Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(obj)
>   {
>       /* Export tabs to be accessed by script */
>       QJSValue qsTab = engine.newQObject(ui->tab);
>       engine.globalObject().setProperty("tabRegistration", qsTab);
> +    AddChildren(ui->tab, qsTab);
>   
>       QJSValue qsTab2 = engine.newQObject(ui->tab_2);
>       engine.globalObject().setProperty("tabCBM", qsTab2);
> +    AddChildren(ui->tab_2, qsTab2);
>   
>       QJSValue qsTab3 = engine.newQObject(ui->tab_3);
>       engine.globalObject().setProperty("tabSMS", qsTab3);
> +    AddChildren(ui->tab_3, qsTab3);
>   
>       QJSValue qsTab4 = engine.newQObject(ui->tab_4);
>       engine.globalObject().setProperty("tabVoiceMail", qsTab4);
> +    AddChildren(ui->tab_4, qsTab4);
>   
>       QJSValue qsTab5 = engine.newQObject(ui->tab_5);
>       engine.globalObject().setProperty("tabUSSD", qsTab5);
> +    AddChildren(ui->tab_5, qsTab5);
>   
>       QJSValue qsTab6 = engine.newQObject(ui->tab_6);
>       engine.globalObject().setProperty("tabSIM", qsTab6);
> +    AddChildren(ui->tab_6, qsTab6);
>   
>       QJSValue qsTab8 = engine.newQObject(ui->tab_8);
>       engine.globalObject().setProperty("tabPosition", qsTab8);
> +    AddChildren(ui->tab_8, qsTab8);
>   
>       QJSValue qsTab9 = engine.newQObject(ui->tab_9);
>       engine.globalObject().setProperty("tabCall", qsTab9);
> +    AddChildren(ui->tab_9, qsTab9);
>   }
>   
>   void Script::SetPath(const QString &path, const QDBusMessage &msg)
> diff --git a/src/control.h b/src/control.h
> index be4a366..c160d61 100644
> --- a/src/control.h
> +++ b/src/control.h
> @@ -57,6 +57,8 @@ public slots:
>       QString Run(const QString &name, const QDBusMessage &msg);
>   
>   private:
> +    void AddChildren(const QWidget *parentW, QJSValue &parentJS);
> +
>       QString dirPath;
>       QJSEngine engine;
>   };

