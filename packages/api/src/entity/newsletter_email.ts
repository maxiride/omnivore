import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm'
import { User } from './user'
import { Subscription } from './subscription'

@Entity({ name: 'newsletter_emails' })
export class NewsletterEmail {
  @PrimaryGeneratedColumn('uuid')
  id!: string

  @Column('varchar')
  address!: string

  @ManyToOne(() => User, (user) => user.newsletterEmails)
  @JoinColumn({ name: 'user_id' })
  user!: User

  @Column('varchar', { nullable: true })
  confirmationCode?: string | null

  @CreateDateColumn()
  createdAt!: Date

  @UpdateDateColumn()
  updatedAt!: Date

  @OneToMany(() => Subscription, (subscription) => subscription.newsletterEmail)
  subscriptions!: Subscription[]

  @Column('text')
  folder!: string

  @Column('text')
  name?: string | null

  @Column('text')
  description?: string | null
}
